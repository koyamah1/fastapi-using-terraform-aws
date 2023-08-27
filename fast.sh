#!/bin/bash
sudo apt-get update
sudo apt install postgresql-client -y
sudo apt install uvicorn -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt-get install -y python3.8 python3-pip python3.8-dev python3.8-venv python3.8-distutils
cd /home/ubuntu
git clone https://github.com/marciovrl/fastapi.git
cd /home/ubuntu/fastapi && python3.8 -m pip install -r requirements.txt
sudo apt update -y
python3.8 -m pip install --upgrade pip
python3.8 -m pip install "fastapi[all]"
export DATABASE_URL=postgresql://${var.db_username}:${var.db_password}@$(terraform output -raw rds_endpoint)/${var.db_name}
cd /home/ubuntu/fastapi && uvicorn app.main:app --reload --workers 1 --host 0.0.0.0 --port 8000
cd /home/ubuntu/fastapi && screen -S fast -dm uvicorn app.main:app --reload --workers 1 --host 0.0.0.0 --port 8000