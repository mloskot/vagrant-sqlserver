# Vagrant SQL Server on Ubuntu Linux

[Vagrant](https://www.vagrantup.com/) configuration to provide users with
virtual environment for hassle-free fun with [SQL Server 2017](https://www.microsoft.com/en-us/sql-server/sql-server-2017).

Looking for SQL Server on Windows VM? Check https://github.com/msabramo/vagrant_sql_server_express

## Features

* Ubuntu 16.10
* [SQL Server 2017 on Linux](https://docs.microsoft.com/en-us/sql/linux/) (official packages by Microsoft)
* [SQL Server command-line tools on Linux](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools)
* Pre-configured with
  * Vagrant default user: `vagrant` with password `vagrant`
  * Port forwarding from host `2433` to guest `1433` (default).
  * Database user `sa` with password `Password123`.
  * Database `master`

## Requirements

* [VirtualBox](https://www.virtualbox.org/) installed.
* [Vagrant](https://www.vagrantup.com/downloads.html) installed.

## Installation

* `git clone` this repository or [download ZIP](https://github.com/mloskot/vagrant-sqlserver/archive/master.zip).
* `cd vagrant-postgis`
* Follow the [Usage](#usage) section.

## Usage

### Vagrant VM

* `vagrant up` to create and boot the guest virtual machine.
First time run, this may take quite a while as the base box image is downloaded
and provisioned, packages installed.

* `vagrant ssh` to get direct access to the guest shell via SSH.
You'll be connected as the vagrant user.
You can get root access with `sudo` command.

* `vagrant halt` to shutdown the guest machine.

* `vagrant destroy` to wipe out the guest machine completely.
You can re-create it and start over with `vagrant up`.

### SQL Server

Using [sqlcmd](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility):

* Connect to SQL Server instance from inside the guest VM

```
vagrant ssh
sqlcmd -S localhost -U SA -P 'Password123' -Q "SELECT name FROM sys.databases;"
```

* Connect to SQL Server instance from host

```
sqlcmd -S localhost,2433 -U SA -P 'Password123' -Q "SELECT name FROM sys.databases;"
```
