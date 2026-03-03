# Project-Systembolaget
In this project we are developing a database for categorise different types of alcohol products and a customer is able to see the different products and make orders. Each product have a main category (beer, wine, whiskey, etc...) and a subcategory (Red wine, dessert wine, singel malt whiskey, etc...).

# Setting up environment
To ensure you have the necessary dependencies when working with this project.
Run ".\.venv\Scripts\activate" to set your terminal to the virtual environment.
Then run "pip install requirements.txt" to download the dependencies.

For saving new dependencies run "pip freeze >> requirements.txt"

# Running the application
to run the app, open up a new cmd window and run the following command:
flask --app app run. Note that since we used individual databases that have the same data you need to change the connection calls to either db.py or connect.py and change the variables to ensure that it connects to your database on your device.


# In regards to the EER diagrams
The image file name ProjectEER_old is the initial EER diagram that we used to model our dabase from and the image file with the name ProjectEER_current is our current diagram that represents how our database looks currently with the modifications we made during the projects course.