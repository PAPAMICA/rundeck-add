#!/bin/bash
NODENAME=$(uname -n)
HOSTNAME=$(hostname -f)
PORT=$(grep "Port " /etc/ssh/sshd_config | awk '{print $2}')
OS=$(echo $(lsb_release -si)-$(lsb_release -sr))
USERNAME=$(whoami)

cat <<EOF >>$NODENAME.yml
$NODENAME
    nodename: $NODENAME
    tags: $OS
    hostname: $HOSTNAME:$PORT
    username: $USERNAME
    ssh-key-storage-path: keys/rundeck
EOF

curl --user 'webdav:webdav1309' -T "$NODENAME.yml" 'http://nurion.papamica.com:1511'
echo "    => Inventory file sended !"
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBDMktRP/iaT8Yf2VrDmqHyuZR+VytUPKKAYxDBRGP8gQ0t8QlhIjpJue8byIdVk/Of7FyapuO9qELCxtmyH0CVS6oCYL8IIkpHHchgyn1oWRBb+SR+Mf5fpha52/MTNvWxSe6Spzk+LG18MRK9C9sR36+WC6hMPWibvp9/1EfN+ESGlBIGsQirAyZ97X/9VX7YT7y7tEt0ro20iLWng3rIn4IHkn37vDLEKcDX1aaIqRqwsBwIEYcuPC7za/IGp4nPH4oFRH9NuTJLESpKVCh0ZwEFNry6pRRD8KvarCKroeIQtU2maKzPwRrje6smk29MZYx7FQM1M1UTXCbDi/iNAP1cRJl7XqGo84OmBuA228KUGcNeBJlxMUDIneFDL1AAZuhwXctgB3TpB5g7U/D9GivzoTxZDmYfst2RXNmhfG82rZjigO0cFYpsqvkC9G8ROfKQ0UeO4e+9dY4uyLSziDbWyOEdHrhLwHeWXm3T8nprAj+NzhZ7hoj9apNc78= root@NURION.PAPAMICA.COM" >> ~/.ssh/authorized_keys
echo "    => SSH Key added !"