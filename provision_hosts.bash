#!/bin/bash

IPADDRESS=`ip addr show enp0s8 | grep 'inet ' | cut -d ' ' -f 6 | cut -d '/' -f1`
START=`echo ${IPADDRESS} | cut -d '.' -f1,2,3`
OFFSET=`echo ${IPADDRESS} | cut -d '.' -f4`

# Obtain the hostkey based on the IP-address and add it to the known_host list 
ssh-keyscan -t ecdsa ${START}.${OFFSET} >> /home/vagrant/.ssh/known_hosts

# obtain the hostname, because you might not know it yet, with the IP address:
EXTERNAL_HOSTNAME=`ssh ${START}'.'${OFFSET} 'hostname'`
# obtain the key ot the new other VM based on hostname and also add to known_hosts
ssh-keyscan -t ecdsa ${EXTERNAL_HOSTNAME} >>  /home/vagrant/.ssh/known_hosts
# so now you have the IP address and the corresponding hostname
# add to /etc/hosts without being asked for "yes/no"
echo  ${START}'.'${OFFSET}' '${EXTERNAL_HOSTNAME} >> /etc/hosts
