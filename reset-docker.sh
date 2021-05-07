#!/bin/bash
# Quick script for restarting docker with sql image after exiting terminal.

# Initiate docker and remove old/terminated sql image.
sudo systemctl start docker
sudo docker rm sql1

# Create new/replacement docker sql image and list active images.
sudo docker run -e "ACCEPT_EULA=Y" \
                -e "SA_PASSWORD=@strongPassword" \
                -p 1433:1433 \
                --name sql1 \
                -h sql1 \
                -d mcr.microsoft.com/mssql/server:2019-latest
sudo docker ps -a
