#!/bin/bash

header=$"Content-Type: application/json"
url=https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com/test/authenticate

curl --header $header --data '{ "email": "test@domain.com", "password": "ThisIsATest" }' --verbose $url
