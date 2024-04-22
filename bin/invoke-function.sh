#!/bin/bash

# Set default values if not already set
source .env

# Dynamically retrieve the URL of the Cloud Function
FUNCTION_URL=$(gcloud functions describe $FUNCTION_NAME --region=$REGION --format='value(httpsTrigger.url)')

# Retrieve the identity token
TOKEN=$(gcloud auth print-identity-token)

# Make the HTTP POST request
response=$(curl -m 70 -X POST $FUNCTION_URL \
  -H "Authorization: bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello World"}')

# Output the response
echo $response
