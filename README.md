# Vagrant SQL Server 2017 on Ubuntu Linux

[Vagrant](https://www.vagrantup.com/) configuration to provide users with
virtual environment for hassle-free fun with [SQL Server 2017](https://www.microsoft.com/en-us/sql-server/sql-server-2017).

Looking for SQL Server 2017 on Windows VM? Check https://github.com/mloskot/vagrant-sqlserver-windows

Looking for SQL Server on Windows VM? Check https://github.com/msabramo/vagrant_sql_server_express

## Features

* Ubuntu 16.04
* Hyper-V or [VirtualBox](https://www.virtualbox.org/)
* [SQL Server 2017 on Linux](https://docs.microsoft.com/en-us/sql/linux/) (official packages by Microsoft)
* [SQL Server command-line tools on Linux](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools)
* Pre-configured with
  * Vagrant default user: `vagrant` with password `vagrant`
  * Port forwarding from host `2433` to guest `1433` (default).
    * *Hyper-V*: No port forwarding configured - default port used.
  * Database user `sa` with password `Password123`.
  * Database `master`.
  * Set SQL Server edition to `Developer` with `MSSQL_PID="Developer`.
  * Other of configuration [Environment variable](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables) set to default.

## Requirements

* Hyper-V enabled or VirtualBox installed.
* [Vagrant](https://www.vagrantup.com/downloads.html) installed.

## Installation

* `git clone` this repository or [download ZIP](https://github.com/mloskot/vagrant-sqlserver/archive/master.zip).
* `cd vagrant-sqlserver`
* Follow the [Usage](#usage) section.

## Usage

### Vagrant VM

* `vagrant up` - create and boot the guest virtual machine.

First time run, this may take quite a while as the base box image is downloaded and provisioned, packages installed.

On Hyper-V, by default, `Default Switch` is preferred. If you prefer to select different switch, see related comment in the `Vagrantfile`.

On Hyper-V, no port forwarding is enabled. Once the provisioning is done, IP address of the guest is printed. Use this IP to connect from host to the SQL Server using the default port.

* `vagrant ssh` - access the guest shell via SSH.

You'll be connected as the vagrant user.
You can get root access with `sudo` command.

* `vagrant halt` - shutdown the guest machine.

* `vagrant destroy` - wipe out the guest machine completely.

### SQL Server

Using [sqlcmd](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility):

* Connect to SQL Server instance from inside the guest VM

```
vagrant ssh
sqlcmd -S localhost -U SA -P 'Password123' -Q "SELECT @@version;"
sqlcmd -S localhost -U SA -P 'Password123' -Q "SELECT name FROM sys.databases;"
```

* Connect to SQL Server instance from host

```
sqlcmd -S localhost,2433 -U SA -P 'Password123' -Q "SELECT name FROM sys.databases;"
```
