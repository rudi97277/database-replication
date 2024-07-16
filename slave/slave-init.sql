-- slave-init.sql
CREATE USER 'repluser'@'%' IDENTIFIED WITH 'mysql_native_password' BY 'replpassword';
GRANT REPLICATION SLAVE ON *.* TO 'repluser'@'%';
FLUSH PRIVILEGES;
FLUSH TABLES WITH READ LOCK;
SHOW MASTER STATUS;

CHANGE MASTER TO 
  MASTER_HOST='mysql-master',
  MASTER_USER='repluser',
  MASTER_PASSWORD='replpassword',
  MASTER_LOG_FILE='mysql-bin.000003', 
  MASTER_LOG_POS= 157;              
START SLAVE;
