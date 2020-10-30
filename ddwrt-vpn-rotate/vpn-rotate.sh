#!/bin/ash
# https://stackoverflow.com/questions/7642743/how-to-generate-random-numbers-in-the-busybox-shell

function randomNumber {
    local digits="${1}" # The number of digits to generate
    local number

    # Some read bytes can't be used, se we read twice the number of required bytes
    dd if=/dev/urandom bs=$digits count=2 2> /dev/null | while read -r -n1 char; do
            number=$number$(printf "%d" "'$char")
            if [ ${#number} -ge $digits ]; then
                    return ${number:0:$digits}
                    break;
            fi
    done
}

function gwSelect {
	randomNumber 1
	local num=$? #(randomNumber 1)

	local count=0
	set -- "be-06.protonvpn.com" "ie-06.protonvpn.com" "it-01.protonvpn.com" "3" "4" "5" "6" "7" "8" "9"
	for i; do
        	if [[ "$count" == "$num" ]]; then
                	echo "$i"
			break;
        	fi
        	count=$((count+1))
	done
}

gw=$(gwSelect)

echo $gw

nvram set openvpncl_remoteip=$gw
nvram commit
restart openvpn

