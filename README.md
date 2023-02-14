# AWS Labs Login


|Title : AWS Lab SSH Login  |
|---------------------------|
|Author : Taher             |
|Date Created : 31/01/2023  |
|Bash Script : awsl.sh      |
|Version : Beta-v.1.1       |



## Description.
I created this script as a side project so I can practice with bash scripts, while I am learning AWS re/start Cloud Practitioner. This script just makes it easier when I have to log into AWS Labs with temporary keys through Ubuntu CLI. I don't have to worry which dir location I am in, as I have created an alias in ./bashrc for this script. The code it self is only 2 lines to log into AWS labs via ssh but I have added extra code like functions, if statements, while case statements so I can learn and experiment coding in bash. I hope you like what I have done so far. You can use this script if it makes it easier for you too and you can modify, add or change features as you wish. All feedback is most welcome. 

## Script Description.
Login to SSH AWS Lab with IP address.
This script only works with AWS Labs 'labsuser.pem' file to login via SSH on Ubuntu/Linux.
It will check if labsuser.pem exists, change the permission to read only, verify IP address
and login to AWS Labs environment via SSH.

## Prerequisite
You will need have access to AWS Lab Workbench.
Before using this script you will need to Download the labsuser.pem file and copy or take note of AWS Lab IP Address from AWS Lab Workbench. You can get the .pem file and IP by clicking Lab Details in the AWS Lab Workbench.

## Features
Can use IP as argument from CLI.
example: bash awsl.sh 10.10.10.10

Added options that too can be executed from CLI.
example: bash awsl.sh -h

Options added are listed below:

-h Displays Help Page on how to use.

-v Display the script version and Author Details.

-d Deletes the old labsuser.pem file to avoid duplication. Use before downloading new file or when you are finished with the lab.

-u Display Usage Details.

-l Display Logo.

### Planed future Options. not part of script yet.

-s Setup to use 'awsl' as a function from any directory/folder/location instead of ./awsl.sh or bash awsl.sh 
    Example of use after setup: awsl 10.10.10.10 from any location in the terminal. You will only need to setup once.

-c Creates new dir location to store & isolate your labsuser.pem file from your ~/Downloads dir where you might have other files stored. You will still need to download labsuser.pem file to ~/Downloads folder 1st, the script will then verify the file and move it to users dir location. You would only need to configure your dir location once.
