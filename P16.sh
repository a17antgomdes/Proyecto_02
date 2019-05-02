#!/bin/bash
# Script to add a user to Linux system
#Antonio Gomes & Nilson Issaoui
if [ $(id -u) -eq 0 ]; then
	read -p "Enter username : " username
	read -p "Enter the name of the person who this account is for: " COMMENT
	#read -p "Enter password : " password
	password=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '');
	#echo $password;
	egrep "^$username" /etc/passwd >/dev/null


else
	echo "Only root may add a user to the system"
	exit 2
fi
