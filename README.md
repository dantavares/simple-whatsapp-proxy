# Simple Whatsapp Proxy

A simple proxy implementation for WhatsApp chat based on: https://github.com/WhatsApp/proxy

If you want a fancy proxy server, go to: https://github.com/WhatsApp/proxy

This implementation just uses "Haproxy" and its proper configuration to enable a working proxy to be used in whatsapp.

This setup is working and active on my Ubuntu 20.04.5 LTS server.

## What you'll need
1. A Linux Server
2. Installed Haproxy
3. Installed openssl

## Setting up your proxy

1. Install haproxy and openssl: 
Example on Ubuntu:
```bash
sudo apt install haproxy openssl
```

2. Create ssl folder on /etc/haproxy
```bash
sudo mkdir /etc/haproxy/ssl
```

3. Enter the ssl folder and create the ssl certificate
```bash
cd /etc/haproxy/ssl
sudo wget https://raw.githubusercontent.com/dantavares/simple-whatsapp-proxy/main/generate-certs.sh
sudo bash generate-certs.sh
```

4. Backup original haproxy config file and download new specific for whatsapp proxy
```bash
cd /etc/haproxy
sudo mv haproxy.cfg haproxy.cfg.bak
sudo wget https://raw.githubusercontent.com/dantavares/simple-whatsapp-proxy/main/haproxy.cfg
```

5. Restart haproxy service
```bash
sudo service haproxy restart
```

6. Check if everything is ok
```bash
sudo service haproxy status
```
If you see "Active: active (running)" on top, everything is Ok!

## Issues
If you have a web server running on this host (like apache, nginx etc) there will be a port conflict and haproxy will throw an error. In this case you will have to edit the "haproxy.cfg" file to change the http and https sections.

In this case, every https section will have to be commented out or removed:
```
#frontend haproxy_v4_https
#  maxconn 27495
#  bind ipv4@*:443 ssl crt /etc/haproxy/ssl/proxy.whatsapp.net.pem
#  bind ipv4@*:8443 ssl crt /etc/haproxy/ssl/proxy.whatsapp.net.pem accept-proxy
#  default_backend wa
```

But in case if you still want to use the http connection, just change the default http port (80) to another one:
```
frontend haproxy_v4_http
  maxconn 27495
  bind ipv4@*:81
  bind ipv4@*:8080 accept-proxy
  default_backend wa_http
```

In these cases you will need to inform in your whatsapp configuration, in addition to the ip address, the port to be used, otherwise it will automatically use the ssh port (443) Example: the host IP is 170:192.168.30 so to use http port defined above should be: 170:192.168.30:81

Do not forget to release and/or redirect the necessary ports for this proxy to work, such as: 80, 443 and 5222
