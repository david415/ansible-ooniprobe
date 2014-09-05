#!/bin/sh
/usr/local/bin/ooniprobe  -l /data/bridge_reachability/ooniprobe.log -c {{ ooni_collector }} blocking/bridge_reachability -f /data/bridge_reachability/bridges.txt -t 400
