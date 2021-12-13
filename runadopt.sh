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

curl --user 'webdav:webdav1309' -T "$NODENAME.yml" 'http://nurion.papamica.com:1511'
echo "    => Inventory file sended !"
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqRxD6h9I3+eVB6kEbAZ3pqBJO5EpWQr/hE0w/pxPYQ6dRC9FlvYJIkvEttnTWGwAaTzW/ysoXsgsJnCDOxG9QTYI1lA+2WhTTDxfYUHD1SKPua6nvrQdu4Z9+8cz5EqR5ppzWUH0lT//0aaYAuvFDuAzicxC4d+Y+9Hik8BgVDG3vXficQCtriRcWaFrKscIkYQKi6PRqMljFeAFVlfvrELkWC38JHhdcTwO6X3SCyGlcqvdkaqhKTb+61ZkiReSVARSB6CswdsG1XmTRFdbBm1WNeCmYhOPDvyEri/E7vY4WvqT5JFrcryMWPVHwE8yjQ5DudpPX5PT6GeABf/MZ3cVJPQ+Wy5/TZLSq4/jkS6UffAM7nLGvSEwWHLoMZRIhF6Z9vrc5pfGFI4pf7lm6z08Tk81s/wkcOw7nZzxElJvFlGq3EI6oCt6GgS92hamoCHwUl7hXFwIvKCfc8Cehsx5pSN8gmOd+l4SdRZsu+fnltlEpLPY97Ul7BAvBHXU= root@NURION.PAPAMICA.COM #RunDeck" >> ~/.ssh/authorized_keys
echo "    => SSH Key added !"
sleep 2
curl -H "Content-Type: application/json" -X POST -d '{"node":"'$NODENAME'"}' https://rundeck.papamica.com/api/40/webhook/U1mWyNjTEKJc6ZjpGF4Q3msb4FIsR7Gb#New_Server_%3E_Agent_Zabbix
echo "    => Install Zabbbix Agent started !"
