# Setup wifi
wpa_passphrase '<ssid_name>' '<ssid_passphrase>' > /etc/wpa_supplicant/wpa_supplicant.conf

# Setup Networking
# Edit /etc/networking/interfaces:
#   auto lo
#   iface lo inet loopback
#   
#   iface wlan0 inet dhcp
#       allow-hotplug
#
#   iface wlan1 inet static
#       allow-hotplug
#       address 192.168.0.1
#       netmask 255.255.255.0
#       broadcast 192.168.0.255
#       network 192.168.0.0
#       gateway 192.168.0.1

echo 'auto lo' > /etc/networking/interfaces
echo 'iface lo inet loopback' >> /etc/networking/interfaces

echo 'auto wlan0' >> /etc/networking/interfaces
echo 'iface wlan0 inet dhcp' >> /etc/networking/interfaces
echo '    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf' >> /etc/networking/interfaces

echo 'auto wlan1' >> /etc/networking/interfaces
echo 'allow-hotplug wlan1' >> /etc/networking/interfaces
echo '    iface wlan1 inet dhcp' >> /etc/networking/interfaces
echo '    address 192.168.0.1' >> /etc/networking/interfaces
echo '    netmask 255.255.255.0' >> /etc/networking/interfaces
echo '    broadcast 192.168.0.255' >> /etc/networking/interfaces
echo '    network 192.168.0.0' >> /etc/networking/interfaces
echo '    gateway 192.168.0.1' >> /etc/networking/interfaces

#Enable networking services
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl start systemd-networkd
systemctl start systemd-resolved
ln -sf /run/system/resolve/resolv.conf /etc/resolv.conf

#Setup script directories
mkdir /scripts
mkdir /scripts/startup
mkdir /scripts/config
mkdir /scripts/atack

#Set triggers for startup scripts
echo '@reboot /scripts/startup.sh' >> /etc/crontab
echo '#!/bin/bash' > /scripts/startup.sh
echo 'sh /scripts/startup/wifi-client.sh' > /scripts/startup.sh


#TODO - fix wifi auto-connect

#Connect to WiFi
echo 'wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf -d wext' > /scripts/startup/wifi-client.sh

#Start dhcp
dhclient

#Run updates
apt-get update
apt-get upgrade -y

#Install better DHCP client
apt-get install -y dhcpcd5
systemctl enable dhcpcd




#Access Point Setup
apt-get install -y hostapd dnsmasq

mkdir /scripts/hostapd

# Edit hostapd.conf:
#   interface=wlan2
#   driver=nl80211
#   ssid=SPIDER
#   hw_mode=g
#   channel=11
#   macaddr_acl=0
#   ignore_broadcast_ssid=0
#   auth_algs=1
#   wpa=2
#   wpa_passphrase=superpass
#   wpa_key_mgmt=WPA-PSK
#   wpa_pairwise=CCMP
#   wpa_group_rekey=86400
#   ieee80211n=1
#   wme_enabled=1

echo 'interface=wlan2' >> /scripts/hostapd/hostapd.conf
echo 'driver=nl80211' >> /scripts/hostapd/hostapd.conf
echo 'ssid=SPIDER' >> /scripts/hostapd/hostapd.conf
echo 'hw_mode=g' >> /scripts/hostapd/hostapd.conf
echo 'channel=11' >> /scripts/hostapd/hostapd.conf
echo 'macaddr_acl=0' >> /scripts/hostapd/hostapd.conf
echo 'ignore_broadcast_ssid=0' >> /scripts/hostapd/hostapd.conf
echo 'auth_algs=1' >> /scripts/hostapd/hostapd.conf
echo 'wpa=2' >> /scripts/hostapd/hostapd.conf
echo 'wpa_passphrase=superpass' >> /scripts/hostapd/hostapd.conf
echo 'wpa_key_mgmt=WPA-PSK' >> /scripts/hostapd/hostapd.conf
echo 'wpa_pairwise=CCMP' >> /scripts/hostapd/hostapd.conf
echo 'wpa_group_rekey=86400' >> /scripts/hostapd/hostapd.conf
echo 'ieee80211n=1' >> /scripts/hostapd/hostapd.conf
echo 'wme_enabled=1' >> /scripts/hostapd/hostapd.conf

hostapd /scripts/hostapd/hostapd.conf

