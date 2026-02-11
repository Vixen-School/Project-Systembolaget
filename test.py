from flask import request
from flask import Flask
import mysql.connector as connector
from Project.project_flask.connect import connectToDatabase
from markupsafe import escape


app = Flask(__name__)

@app.route("/")
def hello_world():
    connector = connectToDatabase()
    return "<p> Hello world! </p>"

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

    
