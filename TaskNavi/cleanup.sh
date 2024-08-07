#!/bin/bash 

#Delete files thet are 30 mins old under mytasks
/30 * * * * find /mnt/c/Users/DELL/mytasks/ -type f -mmin +30 -exec rm {} \;

#System reboot
0 9 * * 1-5 /sbin/shutdown - r now

# Cleaning temporary files
@hourly rm -rf /mnt/c/Users/DELL/AppData/Local/Temp/

# Removing files
0 9 * * 1-5 rm -rf "/mnt/c/Users/DELL/mytasks"/*
0 18 * * 1-5 rm -rf "/mnt/c/Users/DELL/mytasks"/*
