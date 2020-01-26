# SPIDER
## Surface Peripheral Injection, Dissemination, and Reconnaissance

Three wireless interfaces (three external via USB PiHAT):

### 1. Mesh Network
* Provides mesh WiFi network connected to other SPIDERs - SPIDER-web
* Solely an internal network - no external devices connect to mesh
* Potential for centralized C2 node which provides uplink
* Central node running DHCP and is default router
* Failover DHCP on all nodes if DHCP server not detected
* Failover to AutoIP if DHCP completely fails
* Potential for any node attaining uplink to advertize connection and become new mesh-wide uplink
* Requires reporting back to central node

### 2. Scanning
* Monitor mode - always passive
* Constantly scanning using airodump-ng
* Two levels of logging - full and breif
* Full logging
  * Used for unrestricted uplinks
  * Transmits full packet captures from every node back to analysts
  * Generates ~100KB per minute per node
* Breif logging
  * Used for restricted or slow uplinks
  * Transmits only summaries of packet information (Time last seen for all BSSIDs and SSIDs, probe requests, beacon strength, etc.) at normal time intervals
  * Generates ~ 10KB per minute per node, but rate decreases over time (10 minutes yeilds ~30KB total)

### 3. Deauth / KARMA / Social Engineering / Alerts
* Used for active effects - Deauth / Social Engineering / KARMA attacks
* If public alert system is needed, this interface can be used to create the public network which is used to broadcast messages


## TODO
* C2 Structure



## Links
* https://medium.com/swlh/setting-up-an-ad-hoc-mesh-network-with-raspberry-pi-3b-using-batman-adv-1c08ee565165
    Potential for ad-hoc networking
* https://www.greycampus.com/blog/information-security/top-wireless-hacking-tools
    List of various wireless attacks
* https://www.offensive-security.com/kali-linux-arm-images/#1493408272250-e17e9049-9ce8
    Kali Linux for Raspberry Pi (initial image)
* https://github.com/mame82/P4wnP1_aloa
    RPi toolkit including WiFi, Bluetooth, Ethernet, and USB attack vectors
* https://github.com/aircrack-ng/mdk4
    Wireless dauth/spoofing/jamming toolkit
* https://www.aircrack-ng.org/doku.php?id=airodump-ng
    Wireless packet capture
    
    
## Hardware
* Raspbery Pi USB Hat
    https://www.amazon.com/MakerSpot-Stackable-Raspberry-Connector-Bluetooth/dp/B01IT1TLFQ/
* Raspberry Pi Zero
    https://www.canakit.com/raspberry-pi-zero.html
* 32GB Class 10 Micro SD card
    https://www.amazon.com/dp/B07N73LB4T/ref=twister_B07WDD1WXK
* Micro 2.4G/5G WiFi Adaptor with antenna connection
    https://www.amazon.com/Adapter-600Mbps-Desktop-ANEWKODI-External/dp/B07D2YDYPF
* 6in SMA jumper
    https://www.amazon.com/ALLiSHOP-Pigtail-Extension-Assembly-Wireless/dp/B07Z3FHQ5G
* 9dBi High Gain 2.4G/5G Antenna
    https://www.amazon.com/TECHTOO-Antenna-Connector-Wireless-Extender/dp/B00NVFKBWI
* 5000mAh 3.7v LiIon Battery
    https://www.amazon.com/5000mAh-battery-Rechargeable-Lithium-Connector/dp/B07BTSDPVQ
* 3.7v to 5v upconverter
    https://www.amazon.com/Onyehn-Lithium-Battery-Protection-Charger/dp/B07D3SQYKJ
* Micro USB to Male USB converter
    https://www.amazon.com/UCEC-USB-2-0-Adapter-Male/dp/B00TAM0MZW
* GPS/GSM Raspberry Pi Hat
    https://www.amazon.com/dp/B076CPX4NN
