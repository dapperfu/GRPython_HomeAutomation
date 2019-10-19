#!/usr/bin/env bash
# Change TV To HDMI Input 2
echo "tx 4F:82:20:00" | cec-client -s -d 1
