sudo apt update
sudo apt install mysql-server -y
sudo mysql
sudo mysql -e "CREATE USER 'webadmin'@'%' IDENTIFIED BY 'Password&1';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'webadmin'@'%' WITH GRANT OPTION;"

NEW_BIND_ADDRESS="0.0.0.0"

sudo sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = ${NEW_BIND_ADDRESS}/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/mysqlx-bind-address\s*=\s*127.0.0.1/mysqlx-bind-address = ${NEW_BIND_ADDRESS}/" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql

cd /vagrant/scripts

mysql -u webadmin -p"Password&1" < Libreria.sql