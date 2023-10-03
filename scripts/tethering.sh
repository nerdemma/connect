#!/bin/ksh


#ping from a dns lists, from networks dns.list
DNS=8.8.8.8

#convert to arguments
INTERFACE='urndis0'


function ping_checking
{
up='fping -r 1 $DNS'

if [ -z "${up}" ]; then
return 0
else
return 1
fi
}


function print_interface
{
printf $tag":"$(ifconfig $INTERFACE | grep $tag |cut -d ' ' -f$value)"\n"
}


function print_date
{
}


function connect
{
doas dhclient $INTERFACE
ping_checking

if [ $? -eq 1 ]; then
printf "OK - host: $DNS responding to ping \n"
else
printf "Error - host: $DNS not responding to ping \n"
fi
}


#end of the functions

connect


#reduce by an foreach
value=2
tag='inet'
print_interface

value=4
tag='netmask'
print_interface

value=6
tag='broadcast'
print_interface


