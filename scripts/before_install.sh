#!/bin/bash

#download node and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 12.14.0

#create our working directory if it doesn't exist
mkdir -p "/home/ec2-user/express-app"