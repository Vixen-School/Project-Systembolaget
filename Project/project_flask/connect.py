import mysql.connector
from mysql.connector import Error

def connectToDatabase():
    try:
        connector = mysql.connector.connect(
            host="127.0.0.1",
            port=3306,
            user="root",
            password="Gemigenöl9701",
            database="dv1663_project")
        return connector
    except Error as e:
        print("mysql error", e)
        return 1