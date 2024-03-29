#!/bin/python3

from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['GET'])
def get():
  return str("Usage:") #Prints usage information following a GET

@app.route('/', methods=['POST'])
def post():
  received_value = str(request.get_data(as_text=True)) #Gets the data from the POST request
  answer = calculate_answer(received_value)
  return str(answer) #Returns the data to the user

def calculate_answer(received_value):
  #write me
  return

if __name__ == "__main__":
  app.run(host='0.0.0.0')
