#!/bin/sh

pskill ()
{
   local pid;
   pid=$(ps -ax | grep -i $1 | grep -v grep | awk '{ print $1 }' | tr '\n' ' ');
   kill -9 $pid;
   echo -n "killed $1: $pid.";
}

pskill wmc-httpd
