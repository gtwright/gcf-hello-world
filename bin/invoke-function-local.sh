#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | awk '/=/ {print $1}')
fi

# Start the local function
npx @google-cloud/functions-framework --target=helloGET --port=8080 &

# Wait for the server to be ready
sleep 5

FUNCTION_URL=http://localhost:8080

# Test the function
response=$(curl -m 70 -X POST $FUNCTION_URL \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello World"}')
echo "$response"


# Optionally, kill the server after the test
# Find the process using the port and kill it
PID=$(lsof -t -i:8080)
if [ ! -z "$PID" ]; then
    kill $PID
fi
