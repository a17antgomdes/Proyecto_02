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
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username 
		#usermod -c $COMMENT -m $username
		#chage -c $COMMENT $username
		#useradd -c "${COMMENT}" -m ${username}
		#usermod -c "${COMMENT}" -m ${username}
		chfn -f $COMMENT $username
		chage -d 0 $username
		[ $? -eq 0 ] && echo "User has been added to system with his full name!" || echo "Failed to add a user!"
	fi
else
	echo "Only root may add a user to the system"
	exit 2
fi
