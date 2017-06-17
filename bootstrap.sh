#!/usr/bin/env bash
# Part of Vagrant virtual environments for SQL Server 2017 on Ubuntu Linux

# ACCEPT_EULA=Y for truly non-interactive apt-get install mssql-tools
# and post-installation mssql-conf setup step.
export ACCEPT_EULA="Y"
export DEBIAN_FRONTEND="noninteractive"
# Ensure hostname is recognised
sudo sed -i "s/^127\.0\.0\.1.*/127.0.0.1 localhost $HOSTNAME/g" /etc/hosts
# Install pre-requisites
sudo apt-get update -y -q
sudo apt-get -y -q install curl
# Pre-installation
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server.list | sudo tee /etc/apt/sources.list.d/mssql-server.list
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update -y -q
sudo apt-get -y -q install mssql-server unixodbc-dev
## Preserve env ACCEPT_EULA for sudo
sudo -E bash -c 'apt-get -y -q install mssql-tools'
# Post-installation
echo "SQLServer: Patching /opt/mssql/lib/mssql-conf/mssqlconfhelper.py file"
echo "SQLServer: See https://github.com/Microsoft/mssql-docker/issues/111"
sudo patch /opt/mssql/lib/mssql-conf/mssqlconfhelper.py mssqlconfhelper.py.patch
## SQL Server configuration
export SA_PASSWORD="Password123"
echo "SQLServer: running /opt/mssql/bin/mssql-conf setup"
echo "SQLServer: ACCEPT_EULA=$ACCEPT_EULA"
echo "SQLServer: SA_PASSWORD=$SA_PASSWORD"
sudo -E bash -c '/opt/mssql/bin/mssql-conf --noprompt setup'
echo "SQLServer: restarting"
sudo systemctl stop mssql-server
sudo systemctl start mssql-server
sudo systemctl status mssql-server
echo "SQLServer: adding /opt/mssql-tools/bin to PATH in ~/.bashrc"
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
echo "SQLServer: listing all databases"
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT name FROM sys.databases"
echo "SQLServer: DONE"
echo "SQLServer: to connect to the database server from your host,"
echo "           use the host IP"
echo "Guest IP address:"
/sbin/ifconfig | grep 'inet addr:'
echo "Bootstrap: DONE"
