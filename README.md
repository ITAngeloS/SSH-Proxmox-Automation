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
#!/bin/bash

Function to modify SSH configuration on remote hosts
modify_ssh_config() {
    local host_ip=$1
    echo "Modifying sshd_config on $host_ip..."
    ssh "$host_ip" "sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config"
    ssh "$host_ip" "sed -i 's/^#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config"
    ssh "$host_ip" "sed -i 's/^PermitRootLogin yes/#PermitRootLogin yes/' /etc/ssh/sshd_config"
    echo "sshd_config modified on $host_ip."
}
<pre>
  <code class="language-java">
    public class MyFirstClass
    {
        public static void main(String ... args)
        {
            System.out.println("Hello, world!");
        }
    }
  </code>
</pre>
Ask for remote IP addresses
read -p "Enter the IP addresses of the remote hosts (separated by space): " host_ips

Loop through each IP address
for host_ip in $host_ips; do
    copy_public_key "$host_ip"  # Copy the public key to the remote host
    modify_ssh_config "$host_ip"  # Modify the SSH configuration on the remote host
done

🛡️ Security Considerations:
Disabling root login increases security, ensuring that access to the root account over SSH is blocked.
Ensure that your public/private key pair is properly secured and that only authorized users have access to the private key.
