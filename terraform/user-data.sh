#!/bin/bash
# Update system packages
sudo yum update -y
# Install Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
. ~/.nvm/nvm.sh
nvm install --lts
# Install Python and pip
sudo yum install python3 -y
sudo yum install python3-pip -y
# Install Git
sudo yum install git -y
# Clone the repository (assuming your code is in a Git repo)
git clone git@github.com:bhatadarsh/terraform-task.git /home/ec2-user/project
# Navigate to project directory
cd /home/ec2-user/project
# Install and run Flask backend
cd backend
pip3 install -r requirements.txt
pip3 install gunicorn
gunicorn --bind 0.0.0.0:5000 app:app --daemon
# Install and run Express frontend
cd ../frontend
npm install
npm start &
