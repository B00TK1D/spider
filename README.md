# SPIDER
## Surface Peripheral Injection, Dissemination, and Reconnaissance

Four wireless interfaces (three external via USB PiHAT, 1 internal via RPi Zero W):
1. Mesh Network
* Provides mesh WiFi network connected to other SPIDERs - SPIDER-web
* Solely an internal network - no external devices connect to mesh
* Potential for centralized C2 node which provides uplink
* Central node running DHCP and is default router
* Failover DHCP on all nodes if DHCP server not detected
* Failover to AutoIP if DHCP completely fails
* Potential for any node attaining uplink to advertize connection and become new mesh-wide uplink
* Requires reporting back to central node


2. Scanning
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
3. Deauth / KARMA / Social Engineering / Alerts
* Used for active effects - Deauth / Social Engineering / KARMA attacks
* If public alert system is needed, this interface can be used to create the public network which is used to broadcast messages


* C2 Structure
* Upstream data
Scanning logs
Notes
Links
https://github.com/mame82/P4wnP1_aloa
RPi toolkit including WiFi, Bluetooth, Ethernet, and USB attack vectors
https://medium.com/swlh/setting-up-an-ad-hoc-mesh-network-with-raspberry-pi-3b-using-batman-adv-1c08ee565165
Potential for ad-hoc networking



