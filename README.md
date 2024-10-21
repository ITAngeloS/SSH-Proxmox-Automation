🛠️ Proxmox SSH Configuration Script for Ansible
This script configures SSH on multiple Proxmox containers, allowing secure, passwordless access via public keys. It's designed to simplify the connection process for Ansible by modifying the SSH configuration to use public key authentication while disabling root login.

📝 How It Works
💻 Request IP Input: The script prompts the user to enter a list of IP addresses corresponding to the Proxmox containers.

🔐 Copy Public Key: For each specified container, the script copies the public key from the control node to the container, enabling passwordless SSH access.

⚙️ Modify SSH Configuration: The script adjusts the SSH configuration (sshd_config) on each container to:

✅ Enable public key authentication.
📂 Configure the authorized keys file location.
🚫 Disable root login over SSH for added security.
🔄 Repeat for Each Container: The above process is repeated for every container IP entered by the user.

📜 Script Overview
bash
Copy code
#!/bin/bash

# Function to modify SSH configuration on remote hosts
modify_ssh_config() {
    local host_ip=$1
    echo "Modifying sshd_config on $host_ip..."
    ssh "$host_ip" "sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config"
    ssh "$host_ip" "sed -i 's/^#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config"
    ssh "$host_ip" "sed -i 's/^PermitRootLogin yes/#PermitRootLogin yes/' /etc/ssh/sshd_config"
    echo "sshd_config modified on $host_ip."
}

# Ask for remote IP addresses
read -p "Enter the IP addresses of the remote hosts (separated by space): " host_ips

# Loop through each IP address
for host_ip in $host_ips; do
    copy_public_key "$host_ip"  # Copy the public key to the remote host
    modify_ssh_config "$host_ip"  # Modify the SSH configuration on the remote host
done
🚀 Step-by-Step Breakdown
1. 💻 Request IP Input
The script starts by prompting you to enter the IP addresses of the Proxmox containers you want to configure. These IPs are separated by spaces and will be processed one by one.

bash
Copy code
read -p "Enter the IP addresses of the remote hosts (separated by space): " host_ips
2. 🔐 Copy Public Key
After receiving the IPs, the script calls a function (assumed to be copy_public_key "$host_ip") that transfers your public SSH key to each remote container. This allows passwordless SSH access, essential for Ansible operations.

3. ⚙️ Modify SSH Configuration
The modify_ssh_config function takes care of modifying the SSH configuration on each container. Specifically:

✅ Enables public key authentication by uncommenting the relevant line in the sshd_config file:

bash
Copy code
ssh "$host_ip" "sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config"
📂 Ensures the SSH server uses the AuthorizedKeysFile to locate authorized public keys:

bash
Copy code
ssh "$host_ip" "sed -i 's/^#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config"
🚫 Disables root login via SSH to enhance security:

bash
Copy code
ssh "$host_ip" "sed -i 's/^PermitRootLogin yes/#PermitRootLogin yes/' /etc/ssh/sshd_config"
4. 🔄 Repeat for Each Container
The script loops through the list of IPs, applying the key transfer and configuration changes to each container in turn.

⚡ Example Usage
Clone the script to your Proxmox control node.
Run the script in the terminal:
bash
Copy code
./your_script.sh
When prompted, enter the IP addresses of the containers separated by spaces (e.g., 192.168.1.101 192.168.1.102).


<p align="center">
  <a href="#" target="_blank" rel="noreferrer"><img src="https://user-images.githubusercontent.com/75753187/123350185-74ce0900-d528-11eb-848d-d92955dbb944.png" alt="my banner"></a>
</p>

<h3 align="center">
Hi there, I'm <a href="#" target="_blank" rel="noreferrer">Angelo</a> 👋
</h3>

<h2 align="center">
I'm a IT lover 💻
</h2> 

I love the entire process of developing creative websites. I love the challenge of finding caches and spending time to meet new people. Learning how people hide things and where people are likely to look.

### 🤝 Connect with me:

<a href="https://www.linkedin.com/in/yushi95/"><img align="left" src="https://raw.githubusercontent.com/yushi1007/yushi1007/main/images/linkedin.svg" alt="Yu Shi | LinkedIn" width="21px"/></a>
<a href="https://instagram.com/yushi.95"><img align="left" src="https://raw.githubusercontent.com/yushi1007/yushi1007/main/images/instagram.svg" alt="Yu Shi | Instagram" width="21px"/></a>
<a href="https://yushi95.medium.com/"><img align="left" src="https://raw.githubusercontent.com/yushi1007/yushi1007/main/images/medium.svg" alt="Yu Shi | Medium" width="21px"/></a>
</br>
- 💬 If you have any question/feedback, please do not hesitate to reach out to me!

## 🔭 I'm currently working on

- My old projects
- Restaurant Recommendation App (React-Native)
- Mobile + Desktop Spotify Clone (Working on it soon...)
- My next blog
- My CSS skill

## 🌱 I'm currently learning

- 📱 React Native
- Firebase
- React Context API
- Styled Components  

## 💼 Technical Skills

![](https://img.shields.io/badge/Code-React-informational?style=flat&logo=react&color=61DAFB)
![](https://img.shields.io/badge/Code-Redux-informational?style=flat&logo=Redux&color=764ABC)
![](https://img.shields.io/badge/Code-JavaScript-informational?style=flat&logo=JavaScript&color=F7DF1E)
![](https://img.shields.io/badge/Code-Ruby-informational?style=flat&logo=Ruby&color=CC342D)
![](https://img.shields.io/badge/Code-Ruby_on_Rails-informational?style=flat&logo=Ruby-On-Rails&color=CC0000)
![](https://img.shields.io/badge/Code-HTML5-informational?style=flat&logo=HTML5&color=E34F26)
![](https://img.shields.io/badge/Code-PostgreSQL-informational?style=flat&logo=PostgreSQL&color=336791)
![](https://img.shields.io/badge/Code-SQLite-informational?style=flat&logo=SQLite&color=003B57)

</br>

![](https://img.shields.io/badge/Style-Bootstrap-informational?style=flat&logo=Bootstrap&color=7952B3)
![](https://img.shields.io/badge/Style-CSS3-informational?style=flat&logo=CSS3&color=1572B6)
![](https://img.shields.io/badge/Style-styled--components-informational?style=flat&logo=styled-components&color=DB7093)


</br>

![](https://img.shields.io/badge/Tools-Figma-informational?style=flat&logo=Figma&color=F24E1E)
![](https://img.shields.io/badge/Tools-NPM-informational?style=flat&logo=NPM&color=CB3837)
![](https://img.shields.io/badge/Tools-Heroku-informational?style=flat&logo=Heroku&color=430098)
![](https://img.shields.io/badge/Tools-Netlify-informational?style=flat&logo=netlify&color=00C7B7)
![](https://img.shields.io/badge/Tools-Git-informational?style=flat&logo=Git&color=F05032)
![](https://img.shields.io/badge/Tools-GitHub-informational?style=flat&logo=GitHub&color=181717)



The script will automatically configure each container for Ansible access.
🛡️ Security Considerations
Disabling root login increases security, ensuring that access to the root account over SSH is blocked.
Ensure that your public/private key pair is properly secured and that only authorized users have access to the private key.
