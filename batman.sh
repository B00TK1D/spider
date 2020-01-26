#!/bin/bash

#Installs BATMAN mesh networking system

mkdir /scripts/batman
cd /scripts/batman
touch start-batman-adv.sh
chmod +x start-batman-adv.sh

echo "#!/bin/bash" > start-batman-adv.sh
echo "# Tell batman-adv which interface to use" >> start-batman-adv.sh
echo "sudo batctl if add wlan0" >> start-batman-adv.sh
echo "# Activates the interfaces for batman-adv" >> start-batman-adv.sh
echo "sudo ifconfig wlan0 up" >> start-batman-adv.sh
echo "sudo ifconfig bat0 up # bat0 is created via the first command" >> start-batman-adv.sh

touch /etc/network/interfaces.d/bat0
touch /etc/network/interfaces.d/wlan0

echo "auto bat0" > /etc/network/interfaces.d/bat0
echo "iface bat0 inet auto" >> /etc/network/interfaces.d/bat0
echo "    pre-up /usr/sbin/batctl if add wlan0" >> /etc/network/interfaces.d/bat0

echo "auto wlan0" > /etc/network/interfaces.d/wlan0
echo "iface wlan0 inet manual" >> /etc/network/interfaces.d/wlan0
echo "    mtu 1532 # Increase packet size to account for batman-adv header" >> /etc/network/interfaces.d/wlan0
echo "    wireless-channel 1 # Any channel from 1-14" >> /etc/network/interfaces.d/wlan0
echo "    wireless-essid my-ad-hoc-network # Your network name here" >> /etc/network/interfaces.d/wlan0
echo "    wireless-mode ad-hoc" >> /etc/network/interfaces.d/wlan0
echo "    wireless-ap 02:12:34:56:78:9A # This pre-sets your CELL id" >> /etc/network/interfaces.d/wlan0

# Install batman-adv
sudo apt-get install -y batctl
# Have batman-adv startup automatically on boot
echo 'batman-adv' | sudo tee --append /etc/modules
# Prevent DHCPCD from automatically configuring wlan0, THIS IS KEY
echo 'denyinterfaces wlan0' | sudo tee --append /etc/dhcpcd.conf
# Enable interfaces on boot
echo "$(pwd)/start-batman-adv.sh" >> ~/.bashrc
# And done!
echo "Reboot to complete install."

reboot
