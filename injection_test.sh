#!/bin/bash

n=0;
while [ $n -le 2 ]; do

# Display available WiFi adapters
iwconfig | grep IEEE

# Specify which adapter to use
echo -n "Attack interface?"
read interface

# Turn on monitor mode
sudo ifconfig $interface down
sudo iwconfig $interface mode monitor
sudo ifconfig $interface up

sudo airodump-ng $interface

# Specify target AP
echo -n "Attack target? (Copy & Paste BSSID)"
read target

# Specify target channel
echo -n "Attack target radio channel? (numbers only)"
read channel
sudo airmon-ng start $interface $channel

# Testing injection '-9' or '--test'

# Target MAC addr '-a MM:MM:MM:SS:SS:SS'

# Save time and date of test
date >> injection_results.txt

# Perform  test and write results to file
sudo aireplay-ng -9 -a $target $interface  >> injection_results.txt

# Cleanup
sudo ifconfig $interface down
sudo iwconfig $interface mode managed
sudo ifconfig $interface up

let "n=n+1";

done
