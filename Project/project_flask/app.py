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
    ##conn = get_db_connection()
    conn = connectToDatabase()
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
    query = """select Orders.customer_id, OrderItem.product_id, OrderItem.quantity, Orders.order_date from Orders, OrderItem where Orders.order_id = OrderItem.order_id;
"""
    cursor.execute(query)
    row = cursor.fetchall()
    html = ""
    for i in row:
        html += f"<p> {escape(i)} </p>"
    return html
    
@app.route('/price_history/<int:product_id>')
def price_history(product_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Hämta prishistorik för en produkt
    cursor.callproc('GetPriceHistory', (product_id,))
    price_history = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('price_history.html', price_history=price_history, product_id=product_id)

@app.route('/product_sales/<int:product_id>')
def product_sales(product_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Hämta försäljningsstatistik för en produkt
    query = """
    SELECT product_id, name, total_quantity_sold, total_revenue
    FROM ProductSales
    WHERE product_id = %s
    """
    cursor.execute(query, (product_id,))
    product_sales = cursor.fetchone()

    cursor.close()
    conn.close()

    return render_template('product_sales.html', product_sales=product_sales)

@app.route('/sales_by_category/<int:category_id>')
def sales_by_category(category_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Hämta försäljningsstatistik för en kategori
    query = """
    SELECT p.name AS product_name, SUM(oi.quantity) AS total_quantity_sold, SUM(p.price * oi.quantity) AS total_revenue
    FROM Product p
    JOIN OrderItem oi ON p.product_id = oi.product_id
    WHERE p.category_id = %s
    GROUP BY p.name
    """
    cursor.execute(query, (category_id,))
    sales_by_category = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('sales_by_category.html', sales_by_category=sales_by_category, category_id=category_id)

@app.route('/revenue_by_category')
def revenue_by_category():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Hämta totala intäkter per kategori
    query = """
    SELECT c.name AS category_name, SUM(p.price * oi.quantity) AS total_revenue
    FROM Category c
    JOIN Subcategory sc ON c.category_id = sc.category_id
    JOIN Product p ON sc.subcategory_id = p.subcategory_id
    JOIN OrderItem oi ON p.product_id = oi.product_id
    GROUP BY c.name
    """
    cursor.execute(query)
    revenue_by_category = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('revenue_by_category.html', revenue_by_category=revenue_by_category)

@app.route('/price_history/<int:product_id>')
def price_history(product_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.callproc('GetPriceHistory', (product_id,))
        price_history = cursor.fetchall()
        if not price_history:
            return "Ingen prishistorik hittades för denna produkt."
    except Exception as e:
        return f"Ett fel uppstod: {e}"
    finally:
        cursor.close()
        conn.close()

    return render_template('price_history.html', price_history=price_history, product_id=product_id)

@app.route("/category/<int:category_id>")
def category(category_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT p.product_id, p.name, p.price, c.name AS category
        FROM Product p
        JOIN Category c ON p.category_id = c.category_id
        WHERE p.category_id = %s
    """, (category_id,))
    products = cursor.fetchall()

    cursor.close()
    conn.close()
    return render_template("category.html", products=products, category_id=category_id)

@app.route('/price_history/<int:product_id>')
def price_history(product_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.callproc('GetPriceHistory', (product_id,))
        price_history = cursor.fetchall()
        if not price_history:
            return "Ingen prishistorik hittades för denna produkt."
    except Exception as e:
        return f"Ett fel uppstod: {e}"
    finally:
        cursor.close()
        conn.close()

    return render_template('price_history.html', price_history=price_history, product_id=product_id)

if __name__ == "__main__":
    app.run(debug=True)
