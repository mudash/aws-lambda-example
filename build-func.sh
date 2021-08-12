#!/bin/bash

echo -e "\n Building Go lambda function\n"

rm -rf ./bin

cd go-func
env GOOS=linux GOARCH=amd64 go build -o ../bin/get-name
cd ..
