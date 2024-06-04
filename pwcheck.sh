#!/bin/bash

#DO NOT REMOVE THE FOLLOWING TWO LINES
git add $0 >> .local.git.out
git commit -a -m "Lab 2 commit" >> .local.git.out
git push >> .local.git.out || echo


#Your code here

# Initialize Variables
PASSWORD="`cat $1`"

LENGTH=${#PASSWORD}

POINTS=0

# If Password has less than 6, or more than 32 characters, print error message 
if [ ${#PASSWORD} -lt 6 ] || [ ${#PASSWORD} -gt 32 ]; then
  echo "Error: Password length invalid."
else
 # only perform point checks if password is valid

# For any valid password, +1 point per character 
  let POINTS=POINTS+LENGTH


# If the password contains one of the following special characters (#$+%@), +5 points 
  if egrep -q ["#$+%@"] $1; then        # do I need quotes here?
    let POINTS=POINTS+5
  fi
  #echo "points: $POINTS"


# If the password contains at least one number (0-9), +5 points
  if egrep -q [0-9] $1; then
    let POINTS=POINTS+5
  fi


# If the password contains at least one alpha character (A-Za-z), +5 points
  if egrep -q [A-Za-z]+ $1; then        # needs + sign because of "at least"
    let POINTS=POINTS+5
  fi


# If the password contains a repeated alphanumeric character (i.e. aa, bbb, 55555), -10 points
  #if egrep -q '([0-9A-Za-z])\1+' $1; then         # do I have to use alnum?
  if egrep -q '([[:alnum:]])\1+' $1; then
    let POINTS=POINTS-10
  fi


# If the password contains 3 or more consecutive lowercase characters (i.e. bbb, abe, this), -3 points
  if egrep -q [a-z]{3} $1; then
    let POINTS=POINTS-3
  fi


# If the password contains 3 or more consecutive uppercase characters (i.e. BBB, XQR, APPLE), -3 points
  if egrep -q [A-Z]{3} $1; then
    let POINTS=POINTS-3
  fi


# If the password contains 3 or more consecutive numbers (i.e. 55555, 1747, 123, 321), -3 points
  if egrep -q [0-9]{3} $1; then
    let POINTS=POINTS-3
  fi


# Print password score
  echo "Password Score: $POINTS"


 fi #end if statement
