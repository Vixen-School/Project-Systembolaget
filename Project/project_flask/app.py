from flask import Flask, request, render_template, redirect, session
from db import get_db_connection
from connect import connectToDatabase
from markupsafe import escape

app = Flask(__name__)
app.secret_key = "hemligt123"  # behövs för sessioner

# Startsida med alla produkter
@app.route("/", methods=["GET"])
def index():
    search = request.args.get("q", "")
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    if search:
        cursor.execute("""
            SELECT p.product_id, p.name, p.price, c.name AS category
            FROM Product p
            JOIN Category c ON p.category_id = c.category_id
            WHERE p.name LIKE %s
        """, (f"%{search}%",))
    else:
        cursor.execute("""
            SELECT p.product_id, p.name, p.price, c.name AS category
            FROM Product p
            JOIN Category c ON p.category_id = c.category_id
        """)
    products = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template("index.html", products=products, search=search)

# Lägg till produkt i varukorg
@app.route("/add_order", methods=["POST"])
def add_order():
    customer_id = 1  # hårdkodat exempel, kan bytas mot login
    product_id = request.form["product_id"]
    quantity = int(request.form["quantity"])

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Kolla om det finns en öppen order för kunden idag
    cursor.execute("""
        SELECT order_id FROM Orders
        WHERE customer_id=%s AND order_date=CURDATE()
    """, (customer_id,))
    order = cursor.fetchone()
    if order:
        order_id = order["order_id"]
    else:
        cursor.execute("INSERT INTO Orders (customer_id, order_date) VALUES (%s, CURDATE())", (customer_id,))
        order_id = cursor.lastrowid

    # Lägg till produkt i OrderItem
    cursor.execute("""
        INSERT INTO OrderItem (order_id, product_id, quantity)
        VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE quantity = quantity + %s
    """, (order_id, product_id, quantity, quantity))

    conn.commit()
    cursor.close()
    conn.close()
    return redirect("/cart")

# Visa varukorgen
@app.route("/cart")
def cart():
    customer_id = 1
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT order_id
        FROM Orders
        WHERE customer_id=%s AND order_date=CURDATE()
    """, (customer_id,))
    order = cursor.fetchone()

    if not order:
        return "Varukorgen är tom."

    order_id = order["order_id"]

    cursor.execute("""
        SELECT p.name, p.price, oi.quantity,
               (p.price * oi.quantity) AS subtotal
        FROM OrderItem oi
        JOIN Product p ON oi.product_id = p.product_id
        WHERE oi.order_id=%s
    """, (order_id,))
    items = cursor.fetchall()

    total = sum(item["subtotal"] for item in items)

    cursor.close()
    conn.close()
    return render_template("cart.html", items=items, total=total)

@app.route("/checkout", methods=["POST"])
def checkout():
    customer_id = 1
    conn = get_db_connection()
    cursor = conn.cursor()

    # Slutför köpet (ingen status → vi låter ordern vara kvar)
    # Enkelt skol-exempel: bara visa bekräftelse
    cursor.close()
    conn.close()

    return """
    <h1>Tack för ditt köp!</h1>
    <p>Din order är nu registrerad.</p>
    <a href="/">Tillbaka till startsidan</a>
    """

@app.route("/Orders", methods=['GET', 'POST'])
def showOrders():
    connector = connectToDatabase()
    cursor = connector.cursor()
    query = "select * from Orders;"
    cursor.execute(query)
    row = cursor.fetchall()
    html = ""
    for i in row:
        html += f"<p> {escape(i)} </p>"
    return html
    
if __name__ == "__main__":
    app.run(debug=True)
