* An assorted collection of Dockerfiles I use. Build/run instructions are in each subdirectory.
  
  - aosp - for building android projects
  - asterisk - the free PBX
  - Btsync
  - duply
  - grafana-stats
  - nginx - based on Sameersbn/nginx. I had to add a couple things.
  - odoo - based on xcgd/odoo
  - Plex
  - pure-ftpd - on alipine
  - Sabnzbd
  - samba - why didn't anyone else do this? does nobody understand container philosophy?
  - tengine - an nginx fork
  - Transmission (with OpenVPN client and privateinternetaccess.com script)

* The standard UID:GID for the containers that don't run as root is 22000:100. Make sure to update UID/GID as necessary if you have shared data and need it to be easily accessible between containers/host
* MIT License
