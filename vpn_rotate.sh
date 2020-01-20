#!/bin/bash

# Requirements
# 1. Create /var/log/vpn_rotate.log, chmod 777
# 2. All OpenVPN files need to be changed to user file for username/password
# 3. All OpenVPN files need to be placed in Home/vpn/sites directory

# Log current IP
CUR_IP=( `curl ifconfig.me` )
echo "VPN_ROTATE - `date +"%Y-%m-%d_%T"` - INFO: Current IP address is $CUR_IP" > /var/log/vpn_rotate.log

# Obtain list of OpenVPN config files in user directory
VPN_GW_LIST=( `find $HOME/vpn/sites/ -name '*.ovpn'` )

# Obtain the number of elements in the array
RANGE=${#VPN_GW_LIST[@]}

# Randomly select an element in the list
let "NUMBER = RANDOM % $RANGE"

# Log name of selected file
echo "VPN_ROTATE - `date +"%Y-%m-%d_%T"` - INFO: Selecting ${VPN_GW_LIST[$NUMBER]} for new tunnel" > /var/log/vpn_rotate.log

# Copy the selected OpenVpn file to the OpenVPN working directory and rename it
cp ${VPN_GW_LIST[$NUMBER]} "/etc/openvpn/client.conf"

# Get OpenVPN service status
systemctl status openvpn

# Restart OpenVPN service
# systemctl restart openvpn

sleep 30

# Check OpenVPN service status
systemctl status openvpn

# Check new Public IP
NEW_IP=( `curl ifconfig.me` )
echo "VPN_ROTATE - `date +"%Y-%m-%d_%T"` - INFO: New IP address is $NEW_IP" > /var/log/vpn_rotate.log
