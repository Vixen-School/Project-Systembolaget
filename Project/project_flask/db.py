import mysql.connector

def get_db_connection():
    connect = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Gemigenöl9701",
        database="dv1663_project" #dv1663_project
    )
    return connect

