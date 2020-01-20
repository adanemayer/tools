#!/bin/bash

# Obtain list of OpenVPN config files in user directory
VPN_GW_LIST=( `find $HOME/vpn/sites/ -name '*.ovpn'` )

# echo $VPN_GW_LIST

# Obtain the number of elements in the array
RANGE=${#VPN_GW_LIST[@]}
# echo "$RANGE"

# Randomly select an element in the list
let "NUMBER = RANDOM % $RANGE"
# echo "$NUMBER"
# Print name of selected file
echo "Selecting ${VPN_GW_LIST[$NUMBER]} for new tunnel"

cp ${VPN_GW_LIST[$NUMBER]} "$HOME/vpn/temp/client.conf"

ls $HOME/vpn/temp

# ls /home/adrian
