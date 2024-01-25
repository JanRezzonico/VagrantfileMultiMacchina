sudo apt update
sudo apt install mysql-server -y
cd /vagrant/scripts

sudo mysql < Libreria.sql
sudo mysql -e "CREATE USER 'webadmin'@'10.10.20.%' IDENTIFIED BY 'Password&1';"
sudo mysql -e "GRANT ALL PRIVILEGES ON libreria.* TO 'webadmin'@'10.10.20.%' WITH GRANT OPTION;"
sudo mysql -e "CREATE USER 'webadmin'@'localhost' IDENTIFIED BY 'Password&1';"
sudo mysql -e "GRANT ALL PRIVILEGES ON libreria.* TO 'webadmin'@'localhost' WITH GRANT OPTION;"

NEW_BIND_ADDRESS="0.0.0.0"

sudo sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = ${NEW_BIND_ADDRESS}/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/mysqlx-bind-address\s*=\s*127.0.0.1/mysqlx-bind-address = ${NEW_BIND_ADDRESS}/" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql