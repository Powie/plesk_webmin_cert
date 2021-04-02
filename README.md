# plesk_webmin_cert

Copys Plesk LetsEncrypt CERT to Webmin
Script Version: 1.06

The script WEBMINCERT is used if you secured your plesk server also with an LetsEncrypt certificate, Example: server.mydomain.tld

WARNING! This is experimental and only tested on Debian Systems at this time. Make sure you have backed up your PEM files before usage

Supported:

- Plesk 12.5 - Plesk 18 Obsidian
- Debian 8-10
- Webmin - Latest - https://www.webmin.com/

Usage:
- Install the LetsEncrypt Plesk Extension
- Add a webspace with your plesk hostname and secure it with as LetsEncrypt certificate, or secure it by SSLit etc.
- Run the script manually or set up a monthly cron job

Remarks:
The MAILCERT Script try's to get the actual PEM File from the vhost. This file is changed after each renewal of the LetsEncrypt certificate. If the file exists, it will be copied to the known default pem file of the services.

If you have any questions or will get support please contact us at https://forum.powie.de