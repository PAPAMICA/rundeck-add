#!/bin/bash -ev
if [ -z "$1" ]; then
        NODENAME=$(uname -n)
    else
        NODENAME=$1
        sudo hostname $1
fi
IP=$(curl -s http://whatismyip.akamai.com/)
PORT=$(grep "Port " /etc/ssh/sshd_config | awk '{print $2}')
OS=$(echo $(lsb_release -si)-$(lsb_release -sr))
USERNAME=$(whoami)

cat <<EOF >>$NODENAME.yml
$NODENAME:
    nodename: $NODENAME
    tags: $OS
    hostname: $IP:$PORT
    username: $USERNAME
    ssh-key-storage-path: keys/rundeck
    sudo-command-enabled: true
EOF

curl --user 'webdav:webdav1309' -T "$NODENAME.yml" 'http://nurion.papamica.net:1511'
echo "    => Inventory file sended !"
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHKFRjIpp1QrIpq1CPgjeC9bd0wfLaboPJ5i/iA4tO4M0TLw2SYBkNVL93VX+rykw7snGfceq/K4zDhGX8xZYI+JLFMjPpFwHHoP0sGtpDzGdP1vs6h2ucu4Sw9JzBquW5bPwoGjY/Zilm7Hneu8AoolyhQYf65xDD6WG35+s3p++NaPXVXyq2ek4G5IcqDyjGIyBp3xxNPPQvKSty8V+gmK1Cy2qxgjuz1XZRwiLfQFu4MuTEafq4E1+ZUgrIxwvLVBhMT8Z1srGNxzX/N+lL6x4bYH1D04ZiXOmzCLcdX2M3wAjQGUsu79Artnme1SrRO6yADAh8oMAqcp9ug9A5 #RunDeck" >> ~/.ssh/authorized_keys
echo "    => SSH Key added !"
#sleep 2
#curl -H "Content-Type: application/json" -X POST -d '{"node":"'$NODENAME'"}' https://rundeck.papamica.net/api/40/webhook/U1mWyNjTEKJc6ZjpGF4Q3msb4FIsR7Gb#New_Server_%3E_Agent_Zabbix
#echo "    => Install Zabbbix Agent started !"
