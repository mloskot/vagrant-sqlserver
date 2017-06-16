#!/usr/bin/env bash
# Part of Vagrant virtual environments for SQL Server 2017 on Ubuntu Linux

export DEBIAN_FRONTEND="noninteractive"
# SQL Server configuration
export ACCEPT_EULA="Y"
export SA_PASSWORD="Password12!"
# Ensure hostname is recognised
sudo sed -i "s/^127\.0\.0\.1.*/127.0.0.1 localhost $HOSTNAME/g" /etc/hosts
# Install pre-requisites
sudo apt-get update -y -q
sudo apt-get -y -q install curl
# Pre-installation
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server.list | sudo tee /etc/apt/sources.list.d/mssql-server.list
sudo apt-get update -y -q
sudo apt-get -y -q install mssql-server
# Post-installation
## SQL Server configuration settings
export ACCEPT_EULA=Y
export SA_PASSWORD=Password123
echo "SQLServer: running /opt/mssql/bin/mssql-conf setup"
echo "SQLServer: ACCEPT_EULA=$ACCEPT_EULA"
echo "SQLServer: SA_PASSWORD=$SA_PASSWORD"
sudo /opt/mssql/bin/mssql-conf --noprompt setup
echo "SQLServer: restarting"
sudo systemctl stop mssql-server
sudo systemctl start mssql-server
sudo systemctl status mssql-server
echo "SQLServer: DONE"
echo "SQLServer: to connect to the database server from your host,"
echo "           use the host IP"
echo "Guest IP address:"
/sbin/ifconfig | grep 'inet addr:'
echo "Bootstrap: DONE"
