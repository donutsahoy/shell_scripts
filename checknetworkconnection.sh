#!/bin/bash

user=$(whoami)
logs_directory="/home/"$user"/NetworkLogs/"

google_ping_log=""$logs_directory"google_ping.log"
router_ping_log=""$logs_directory"router_ping.log"
google_traceroute=""$logs_directory"google_traceroute.log"

google_address="www.google.com"
router_address="192.168.1.1"

function make_logs_directory () {
	if [ ! -d "$logs_directory" ]; then
		mkdir "$logs_directory"
	fi
}

function ping_google () {
	ping -D  -c 6 -i 8 "$google_address" | while read row; do 
	    if [[ $row == \[*\]* ]]; then 
        	echo -n \[$(date -d "@$(echo $row| sed 's/^\[//' | sed 's/\].*//')")\] ;
	    fi ; 
	    echo $row | sed 's/\[.*\]//' <<< "$row"; 
	done
}

function log_google_pings () {
	ping_google >> "$google_ping_log"
	echo $'\n' >> "$google_ping_log"
}

function ping_router () {
	ping -D  -c 6 -i 8 "$router_address" | while read row; do 
	    if [[ $row == \[*\]* ]]; then 
        	echo -n \[$(date -d "@$(echo $row| sed 's/^\[//' | sed 's/\].*//')")\] ;
	    fi ; 
	    echo $row | sed 's/\[.*\]//' <<< "$row"; 
	done
}

function log_router_pings () {
	ping_router >> "$router_ping_log"
	echo $'\n' >> "$router_ping_log"
}

function traceroute_google () {
	traceroute "$google_address" >> "$google_traceroute"
	echo $'\n' >> "$google_traceroute"
}

function run_traceroute_twice () {
	traceroute_google
	sleep 15s
	traceroute_google
	sleep 15s
	traceroute_google
	sleep 15s
	traceroute_google
}
###################################
########## SCRIPT START ###########

make_logs_directory

log_google_pings &

log_router_pings &

traceroute_google &