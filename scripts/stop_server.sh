#!/bin/sh

pskill ()
{
   local pid;
   pid=$(ps -ax | grep -i $1 | grep -v grep | awk '{ print $1 }' | tr '\n' ' ');
   echo -n "killing $1: $pid...";
   kill -9 $pid;
   echo "slaughtered."
}

pskill wmc-httpd
