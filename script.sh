#!/bin/bash
# Copy the public key to host
copy_public_key() {
    local host_ip=$1
    echo "Copiando la chiave pubblica su $host_ip..."
    ssh-copy-id -i ~/.ssh/ansible.pub "$host_ip"
    echo "Chiave pubblica copiata su $host_ip."
}

# Modify /etc/ssh/sshd_config
modify_ssh_config() {
    local host_ip=$1
    echo "Modificando il file sshd_config su $host_ip..."
    ssh "$host_ip" "sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config"
    ssh "$host_ip" "sed -i 's/^#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config"
    ssh "$host_ip" "sed -i 's/^PermitRootLogin yes/#PermitRootLogin yes/' /etc/ssh/sshd_config"
                echo "File sshd_config modificato su $host_ip."
    
}

# Ask for remote IP address prompt
read -p "Inserisci gli indirizzi IP degli host remoti (separati da spazio): " host_ips

# For every host
for host_ip in $host_ips; do
    copy_public_key "$host_ip"
    modify_ssh_config "$host_ip"
done
