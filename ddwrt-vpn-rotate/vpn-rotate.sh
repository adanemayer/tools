#!/bin/ash
# https://stackoverflow.com/questions/7642743/how-to-generate-random-numbers-in-the-busybox-shell

function randomNumber {
    local digits="${1}" # The number of digits to generate
    local number

    # Some read bytes can't be used, se we read twice the number of required bytes
    dd if=/dev/urandom bs=$digits count=2 2> /dev/null | while read -r -n1 char; do
            number=$number$(printf "%d" "'$char")
            if [ ${#number} -ge $digits ]; then
                    echo ${number:0:$digits}
                    break;
            fi
    done
}

randomNumber 1


nvram set openvpncl_remoteip=be-06.protonvpn.com
nvram commit
restart openvpn

