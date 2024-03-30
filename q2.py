#!/bin/python3

from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route('/', methods=['GET'])
def get():
    return ("Instructions for Maor & Ben Query App.\n"
            "To use this service, send a POST request with your SQL query.\n"
            "Ensure your queries are correctly formatted.\n"
            "Example using curl: curl -d -X POST http://127.0.0.1:5000 \"query=SELECT * FROM my_table\" ")


@app.route('/', methods=['POST'])
def post():
  received_value = str(request.get_data(as_text=True)) #Gets the data from the POST request
  answer = calculate_answer(received_value)
  return str(answer) #Returns the data to the user

def calculate_answer(received_value):
  #We create a helper bash script that runs the query
  output = subprocess.check_output(["./query_template.sh", received_value], text=True) #We used subprocess.check_output instead of subprocess.call, because we need the output and not the exit status of the process.
  return output

if __name__ == "__main__":
  app.run(host='0.0.0.0')
