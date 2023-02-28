#!/bin/bash

echo "### Menu ###"
echo "1. ls"
echo "2. pwd"
echo "3. Exit"
echo "Enter your choice"

read choice

case "$choice" in
    1) ls 
    ;;
    2) pwd 
    ;;
    *) exit
    ;;
esac

