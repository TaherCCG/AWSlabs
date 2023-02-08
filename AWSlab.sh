#!/bin/bash
#
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Title : AWS Lab SSH Login
#Arthor : Taher Mahmood
#Date : 31/01/2023
#Version:Beta-V0.1
#
#Description : Login to AWS Lab SSH with IP address.
#You will only need to input IP address to login, you will not need to use command lines 
#to set file permissions or SHH login.
#
#Before using this script you will need to Download the labsuser.pem file 

clear
echo "Login to AWS Labs"
echo
echo "Ensure You have downloaded labsuser.pem file into you Downloads/ drictory before you continue."
echo "labusers.pem can be found in AWS Labs excersize  by clicking on Details tab."

echo
echo
cd /home/trigz/Downloads  	#change to the directory path where you save/download labsuser.pem file.
ls -l				# Confirm labsuser.pem exsits.
echo
echo
read -p "Do you want to continue y/n? " -n 1 -r	#Asks to confirm if you want to continue.
echo    # (optional) move to a new line.
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 	#handle exits from function if answer is N/n.
fi

echo
echo "please  input the AWS Labs IP address below:"  	#Asks for ip address.

read varIP     			# stores IP address.

cd /home/trigz/Downloads    	#Changes directory to the path where labsuser.pem is stored/dowloaded.
pwd				# Prints Working directory.
chmod 400 /home/trigz/Downloads/labsuser.pem   #Makes the labsuser.pem read only.
ssh -i labsuser.pem ec2-user@$varIP  #logins into AWS lab using secure shell.
