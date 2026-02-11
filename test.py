from flask import request
from flask import Flask
import mysql.connector as connector
from connect import connectToDatabase
from markupsafe import escape


app = Flask(__name__)

@app.route("/")
def hello_world():
    connector = connectToDatabase()

@app.route("/Orders", methods=['GET', 'POST'])
def showOrders():
    connector = connectToDatabase()
    cursor = connector.cursor()
    query = "select * from Customers;"
    cursor.execute(query)
    for row in connector:
        return f"<p> {escape(row)} </p>"

    
