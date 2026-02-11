from flask import request
from flask import Flask
import mysql.connector as connector
from connect import connectToDatabase


app = Flask(__name__)

@app.route("/")
def hello_world():
    connector = connectToDatabase()

@app.route("/Orders", methods=['GET'])
def hello_world():
    connector = connectToDatabase()
    connector.


    
