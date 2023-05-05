#! /usr/bin/python3

"""
This is an example Flask | Python | Psycopg2 | PostgreSQL
application that connects to the 7dbs database from Chapter 2 of
_Seven Databases in Seven Weeks Second Edition_
by Luc Perkins with Eric Redmond and Jim R. Wilson.
The CSC 315 Virtual Machine is assumed.

John DeGood
degoodj@tcnj.edu
The College of New Jersey
Spring 2020

----

One-Time Installation

You must perform this one-time installation in the CSC 315 VM:

# install python pip and psycopg2 packages
sudo pacman -Syu
sudo pacman -S python-pip python-psycopg2

# install flask
pip install flask

----

Usage

To run the Flask application, simply execute:

export FLASK_APP=app.py 
flask run
# then browse to http://127.0.0.1:5000/

----

References

Flask documentation:  
https://flask.palletsprojects.com/  

Psycopg documentation:
https://www.psycopg.org/

This example code is derived from:
https://www.postgresqltutorial.com/postgresql-python/
https://scoutapm.com/blog/python-flask-tutorial-getting-started-with-flask
https://www.geeksforgeeks.org/python-using-for-loop-in-flask/
"""
import requests
import psycopg2
import psycopg2.extras
from config import config
from flask import Flask, render_template, request, make_response,redirect,flash
from flaskext.mysql import MySQL

# Connect to the PostgreSQL database server
def connect(query):
    print (query)
    conn = None
    try:
        # read connection parameters
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the %s database...' % (params['database']))
        conn = psycopg2.connect(**params)
        print('Connected.')
      
        # create a cursor
        cur = conn.cursor(cursor_factory = psycopg2.extras.DictCursor)
        
        # execute a query using fetchall()
        cur.execute(query)
        rows = cur.fetchall()

        # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
    # return the query result from fetchall()
    return rows
 
# app.py
app = Flask(__name__)

@app.route("/")
def form():
    return render_template('index.html')
@app.route('/landing') 
def index(): 
    rows= connect("SELECT DISTINCT county FROM municipality_data;") 
    return render_template("my-form.html",rows=rows )


@app.route('/municipality', methods = ['GET', 'POST']) 
def county(): 
    rows = connect("SELECT DISTINCT municipality FROM municipality_data WHERE county = '"+ request.form.get('county')+"';") 
    return render_template("municipality.html",rows=rows )

# handle venue POST and serve result web page
@app.route('/venue-handler', methods=['POST'])
def venue_handler():
    rows = connect('SELECT venue_id, title FROM events WHERE venue_id = ' + request.form['venue_id'] + ';')
    heads = ['venue_id', 'title']
    return render_template('my-result.html', rows=rows, heads=heads)

# handle query POST and serve result web page
@app.route('/query-handler', methods=['POST'])
def query_handler():
    rows = connect(request.form['query'])
    return render_template('my-result.html', rows=rows)

if __name__ == '__main__':
    app.run(debug = True)

#Query #1
@app.route('/test', methods=['POST'])
def test():
    rows = connect('SELECT solar_installations.municipality, solar_installations.county, energy_data.total_electricity, solar_installations.total_size_of_system, solar_installations.year FROM solar_installations JOIN energy_data ON solar_installations.municipality = energy_data.municipality AND solar_installations.county=energy_data.county AND solar_installations.year=energy_data.year;')
    heads = ['Municipality', 'County', 'Total Electricty', 'Size of system', 'Year']
    return render_template('my-result.html', rows=rows, heads=heads)
# Route after choosing municipality and county   
@app.route('/query1', methods=['GET','POST'])
def query1():
    rows = connect("SELECT municipality, county, total_electricity, year FROM energy_data WHERE municipality = '"+ request.form.get('municipality')+"';")
    heads = ['Municipality', 'County', 'Total Electricty', 'Year']
    return render_template('my-result.html', rows=rows, heads=heads)

#Query #2
@app.route('/numEv', methods=['POST'])
def numEv():
    rows = connect("SELECT electric_vehicles.municipality, electric_vehicles.county, electric_vehicles.number_of_evs, electric_vehicles.year, energy_data.total_electricity FROM electric_vehicles JOIN energy_data ON electric_vehicles.municipality=energy_data.municipality AND electric_vehicles.year=energy_data.year;")
    heads = ['Municipality', 'County', 'Number Of EVs', 'Year', 'Total Electrity']
    return render_template('my-result.html', rows=rows, heads=heads)


#Query #3
@app.route('/ev_percent', methods=['POST'])
def ev_percent():
    rows = connect("SELECT electric_vehicles.municipality, electric_vehicles.county, electric_vehicles.total_personal_vehicles, electric_vehicles.percent_of_evs, electric_vehicles.year, energy_data.total_natural_gas, energy_data.total_electricity FROM electric_vehicles JOIN energy_data ON electric_vehicles.municipality=energy_data.municipality AND  electric_vehicles.year=energy_data.year;")
    heads = ['Municipality', 'County', 'Total Vehicles', 'Percent of EVs', 'Year', 'Natural Gas', 'Total Energy']
    return render_template('my-result.html', rows=rows, heads=heads)

#Query #5
@app.route('/solarvgas', methods=['POST'])
def solarvgas():
    rows = connect("SELECT sp.municipality, sp.county, sp.year, sp.total_num_installations, sp.total_size_of_system, ed.total_electricity, ed.total_natural_gas FROM solar_installations sp JOIN energy_data ed ON sp.municipality = ed.municipality AND sp.year = ed.year;")
    heads = ['Municipality', 'County', 'Year', 'Total Number of Solar Installations', 'Total Size of Solar Installations', 'Total Electricty', 'Total Amount of Natural Gas Used']
    return render_template('my-result.html', rows=rows, heads=heads)

#Query #5
@app.route('/mostSolar', methods=['POST'])
def mostSolar():
    rows = connect("SELECT solar_installations.municipality, solar_installations.county, CAST(REPLACE(solar_installations.total_size_of_system, ',', '') AS DECIMAL) FROM Solar_installations GROUP BY total_size_of_system, municipality, county ORDER BY CAST(REPLACE(solar_installations.total_size_of_system, ',', '') AS DECIMAL) DESC LIMIT 20;")
    heads = ['Municipality', 'County', 'Total Size of Solar Systems']
    return render_template('my-result.html', rows=rows, heads=heads)
