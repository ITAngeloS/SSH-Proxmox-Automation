# 🛠️ Proxmox SSH Configuration Script for Ansible
This script configures SSH on multiple Proxmox containers, allowing secure, passwordless access via public keys. It's designed to simplify the connection process for Ansible by modifying the SSH configuration to use public key authentication while disabling root login.

📝 How It Works: <br>
💻 Request IP Input: The script prompts the user to enter a list of IP addresses corresponding to the Proxmox containers.

🔐 Copy Public Key: For each specified container, the script copies the public key from the control node to the container, enabling passwordless SSH access.

⚙️ Modify SSH Configuration: The script adjusts the SSH configuration (sshd_config) on each container to:

✅ Enable public key authentication.
📂 Configure the authorized keys file location.
🚫 Disable root login over SSH for added security.
🔄 Repeat for Each Container: The above process is repeated for every container IP entered by the user.

📜 Script Overview:

<pre>
  <code class="language-java">
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
  </code>
</pre>

🛡️ Security Considerations:
Disabling root login increases security, ensuring that access to the root account over SSH is blocked.
Ensure that your public/private key pair is properly secured and that only authorized users have access to the private key.
