# Simple Whatsapp Proxy

A simple proxy implementation for WhatsApp chat based on: https://github.com/WhatsApp/proxy

If you want a fancy proxy server, go to: https://github.com/WhatsApp/proxy

This implementation just uses "Haproxy" and its proper configuration to enable a working proxy to be used in whatsapp.

This setup is working and active on my Ubuntu 20.04.5 LTS server.

## What you'll need
A Ubuntu Server (Other similar linux distributions should work)

## Setting up your proxy
1. Enter on /opt/ folder and download script file:
```bash
cd /opt
sudo wget https://raw.githubusercontent.com/dantavares/simple-whatsapp-proxy/main/wa_proxy.sh
```

2. Set script as executable
```bash
sudo chmode +x wa_proxy.sh
```

3. Download systemd service, enable it and execute it
```bash
cd /etc/systemd/system
sudo wget https://raw.githubusercontent.com/dantavares/simple-whatsapp-proxy/main/wa_proxy.service
sudo systemctl enable --now wa_proxy
```

4. Check Proxy Status
```bash
sudo systemctl status wa_proxy
```
If you see "code=exited, status=0/SUCCESS", everything is Ok!

5. Now release and/or redirect port 5222 for this proxy to work, and verify on your WhatsApp App on Proxy Server config, and put: {You Server IP:5222}
