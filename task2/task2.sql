cd "C:/Program Files/MySQL/MySQL Server 8.0/bin/"
./mysql
create database example;
create table example.users(`id` INT serial default value, `name` varchar(256));
show databases;
show tables;
exit
./mysqldump -uroot -p  example > E:/database.sql
./mysqldump -uroot -p  example1 /< E:/database.sql
OS Windows 10 , Programs VSCODE