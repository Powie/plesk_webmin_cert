#!/bin/bash
#########################################################################
# Plesk LetsEncrypt Certificate - copy to Webmin                        #
# Powie . www.powie.de                                                  #
# V1.04                                                                 #
# For Plesk / Debian                                                    #
######################################################################### 
# first we define our common hostname as uses by our plesk host and cert!
HOSTNAME=$(hostname)
echo -e "Server name set to: \e[4m$HOSTNAME"
echo -e "\e[0mIf this is incorrect please set custom hostname in script."
#
# Set hostname here if custom. Example: HOSTNAME=server1.boisehosting.net
#HOSTNAME="artus.be-webspace.net"
#
# that's all for now
# nothing below need to be changed
#
#
#
# here we start
# This is our http conf we are looking into it
CONFFILE=/var/www/vhosts/system/${HOSTNAME}/conf/httpd.conf
CONFFILE2=/var/www/vhosts/system/${HOSTNAME}/conf/httpd_ip_default.conf

#we need some functions
#get the pem file from apache conf, because its written there after changes
getpemfile() {
    #echo "suche"
    CERT=$(grep -m 1 SSLCertificateFile ${CONFFILE})
    CERTFILE=${CERT:20}
    if [ ! "$CERTFILE" ]; then
        CERT=$(grep -m 1 SSLCertificateFile ${CONFFILE2})
        CERTFILE=${CERT:20}
    fi
    echo "Plesk certificate located at:${CERTFILE}"
}

#copy pem to webmin
certforwebmin () {
    if [ -e /etc/webmin/miniserv.pem ]
    then
        if diff  /etc/webmin/miniserv.pem $CERTFILE > /dev/null
            then
                echo -e "\e[33mSkipped: \e[39mWebmin already up to date."
            else
                cp ${CERTFILE} /etc/webmin/miniserv.pem
                echo -e "\e[32mSUCCESS: \e[39mWebmin Certificate Updated"
                systemctl restart webmin
            fi
    fi
}

#copy the cert file to the services
copycerts() {
    certforwebmin
}

#now we start
if [ -e ${CONFFILE} ]
then
    getpemfile
    if [ -e ${CERTFILE} ]
    then
        copycerts
        exit 0
    else
        echo "cert file doesnt exists"
        exit 1
    fi
else
    echo "conf file not found"
    exit 1
fi