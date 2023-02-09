#!/bin/bash
#
#
########################################
#Title : AWS Lab SSH Login             #
#Author : Taher Mahmood                #
#Date Created: 31/01/2023              #
#                                      #
#AWSLab.sh                             #
#beta-v.1.1                            #
########################################
#
#Description: Login to SSH AWS Lab with IP address.
#This script only works with AWS Labs 'labsuser.pem' file to login via SSH on Ubuntu.
#It will check if labsuser.pem exists, change the permission to read only, verify IP address
#and login to AWS Labs environment via SSH.
# Usage example: bash awsl.sh 10.10.10.10
#
#This script is designed for anyone who uses AWS labs on a Linux system with temporary lab keys.
#The code is safe and will not do any harm to your system, but you are using this 
#script at your own risk. You are most welcome to check the code and alter as you wish.
#You can get this script from my github: https://github.com/Trigzi/AWSL
#
#Prerequisite: Need to have acces to AWS Labs Workbeanch to download labsuser.pem
#Before using this script you will need to Download the labsuser.pem via AWS Lab Workbench.
#By displaying Lab Details and then Downloading labsuser.pem.  You will also need to make
#a note of the IP address for the Lab.
#

############################################################
# Logo                                                     #
############################################################

Logo()
{
echo
echo "╭━━━━╮╱╱╱╱╱╱╱╱╱╭━━━╮╱╱╱╭━┳╮"
echo "┃╭╮╭╮┃╱╱╱╱╱╱╱╱╱┃╭━╮┃╱╱╱┃╭╯╰╮"
echo "╰╯┃┃┣┻┳┳━━┳━━━╮┃╰━━┳━━┳╯╰╮╭┫╭╮╭┳━━┳━┳━━╮"
echo "╱╱┃┃┃╭╋┫╭╮┣━━┃┃╰━━╮┃╭╮┣╮╭┫┃╰╯╰╯┃╭╮┃╭┫┃━┫"
echo "╱╱┃┃┃┃┃┃╰╯┃┃━━┫┃╰━╯┃╰╯┃┃┃┃╰╮╭╮╭┫╭╮┃┃┃┃━┫"
echo "╱╱╰╯╰╯╰┻━╮┣━━━╯╰━━━┻━━╯╰╯╰━┻╯╰╯╰╯╰┻╯╰━━╯"
echo "╱╱╱╱╱╱╱╭━╯┃╱╱╱"
echo "╱╱╱╱╱╱╱╰━━╯╱╱™"
echo
}

# Set variables
IP=$1  # Store IP

############################################################
# Help                                                     #
############################################################
Help()
{ # Display Help
clear
echo " +++++ Help Page +++++"
echo 
echo "+++ Description: Login to SSH AWS Lab with IP address."
echo "This script only works with AWS Labs 'labsuser.pem' file to login via SSH on Ubuntu."
echo "It will check if labsuser.pem exists, change the permission to read only, and login" 
echo "to AWS Labs enviroment via SSH."
echo " Usage example: bash awsl.sh 10.10.10.10"
echo
echo "+++ Requirement before using the script:"
echo "Before using this script you will need to Download the labsuser.pem" 
echo "This can be downloaded from AWS Lab Workbench by clicking on 'Details'"
echo "The labsuser.pem file will need to be downloaded to ~/Downloads folder/dir"
echo 
echo "+++ IP ADDRESS:"
echo "IP needs to be a valid AWS Lab IP Address, obtained from AWS Labs Workbech,"
echo "by clicking on 'Details' copy and paste to avoid mistakes."
echo "If by mistake you do put the wrong IP Address you might get prompted to enter password"
echo "or no response from AWS Lab server. Press CTRL + C and try again with correct IP." 
echo 
echo "+++ Usage:"
echo "DO NOT USE THE SCRIPT WITH OPTION AND IP ADDRESS." 
echo " Example: bash awsl.sh -h 10.10.10.10 this will lead to a syntax Error."
echo "Use one or the other as shown below"
echo " example with option: bash awsl.sh -h Displays help page"
echo " example with IP : bash awsl.sh 10.10.10.10 Logs into AWS"
echo
echo "+++ Options:"
echo " -h   Displays Help Page (this page)"
echo " -v   Display the script version and Author Details"
echo " -d   Deletes the old labsuser.pem file to avoid duplication. Use before downloading new file"
echo "      or when you are finished with the lab" 
echo " -u   Display Usage Details only"
echo "+++   Next Update:"
echo " -s   Setup to use awsl as a function from any directory/folder/location"
echo "      Example: awsl 10.10.10.10 from any location in the terminal"
echo "      You would only need to do this once."
echo " -c   Creates new dir location to store & isolate your labsuser.pem file "
echo "      from your ~/Downloads dir where you might have other files stored."
echo "      You will still need to download to ~/Downloads folder 1st."
echo "      You would only need to do this once."
echo 
echo "+++ Terms of Use:"
echo "This script is designed for anyone who uses AWS labs on a Linux system with temporary lab key."
echo "The code is safe and will not do any harm to your system, but you are using this" 
echo "script at your own risk. You are most welcome to check the code and alter as you wish."
echo 
echo 
}

############################################################
# Usage Info                                               #
############################################################
Ui()
{
echo "+++++ Usage +++++"
echo
echo "Usage: bash awsl.sh [OPTION] or <AWS LAB IP ADDRESS>"
echo " or: ./awsl.sh [OPTION] or <AWS LAB IP ADDRESS>"
echo " or: awsl [OPTION] or <AWS LAB IP ADDRESS>" 
echo
echo "DO NOT USE [OPTION] WITH <AWS LAB IP ADDRESS>"
echo " Example: bash awsl.sh -h 10.10.10.10 this will lead to a syntx Error."
echo 
echo "Options:"
echo " -d Delete old .pem file"
echo " -h Display Help page. Please read if its your 1st time using this script"
echo " -v Version."
echo " -u Display Usage Details only (this page)"
Logo
}

############################################################
# Version                                                  #
############################################################
Vers()
{
echo "Title : AWS Lab SSH Login"
echo "Author : Trigz (Taher Mahmood)"
echo
echo "Bash script :awsl.sh"
echo "Version :Beta-v.1.1"
echo 
Logo
}

rmf()
{ 
#Remove .pem file if exist
FILE=~/Downloads/labsuser.pem
if [ ! -f "$FILE" ]; then
echo "$FILE does not exist.";
echo "Your good to go"
exit 0
fi
echo "press y to delete"
rm -r ~/Downloads/*.pem
echo "labsuser.pem deleted" 
}
############################################################
# Process the input options.                               #
############################################################
# Get the options
while getopts ":hvdulsc" option; do
case $option in
h) # display Help
Help
exit;;
v) # display Version
Vers
exit;;
d) #delete .pem file
rmf
exit;;
u) # display Usage Information
echo "Usage info"
Ui
exit;;
l) # display Logo
echo "Logo"
clear
Logo
exit;;
s) # display Script Setup
echo "Script Setup -- Coming Soon"
echo "Ths feature will allow you to run the script from any dir location in the terminal"
echo "by using 'AWSL' as command instead of './awsl.sh or bash awsl.sh'.  At the moment " 
echo "can only run the script from the dir where it is stored"
Vers
exit;;
c) # Configure file Dir
echo "Configure Dir -- Coming Soon"
echo "This feature will allow you to configure your own dir for script location  "
echo "and the location where you could store the .pem file."
Vers
CDir
exit;;
\?) # Invalid option
echo "Error: Invalid option"
Ui
exit;;
esac
done
############################################################
# Check if IP is Valid                                     #
############################################################
if [[ $# -eq 0 ]] ; 
then
echo "Syntax Error"
echo 
Ui
exit 0
fi
if [[ $IP =~ [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
echo "IP Validation Successful"
else
echo "Error: Not A Valid IP"
Ui
exit 0
fi
############################################################
# Check if .pem file exists                                #
############################################################
cd ~/Downloads #change to the directory path where you save/download labsuser.pem file.
FILE=~/Downloads/labsuser.pem
if [ ! -f "$FILE" ]; then
echo "Error: $FILE does not exist.";
echo "Downloaded labsuser.pem file into you Downloads/ drictory before you continue."
echo "labusers.pem can be found in AWS Labs Workbench by clicking on 'Details' tab."
exit 0
fi
############################################################
# Login to AWS Lab                                         #
############################################################
echo "Login to AWS SSH Labs"
echo
echo " Using $IP to login to AWS SSH Labs"
echo
echo " Please Verify the IP address before you continue"
echo 
pwd # Prints Working directory.
read -p "Do you want to continue y/n? " -n 1 -r #Asks to confirm if you want to continue.
echo # (optional) move to a new line.
if [[ ! $REPLY =~ ^[Yy]$ ]] #
then
[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 #handle exits from function if answer is N/n.
fi
chmod 400 /home/trigz/Downloads/labsuser.pem #Makes the labsuser.pem read only.
ssh -i labsuser.pem ec2-user@$IP #logins into AWS lab using secure shell.