#! /bin/bash

sudo systemctl daemon-reload
sudo systemctl start myapp
sudo systemctl status myapp
curl http://localhost:3000/

