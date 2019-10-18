#!/usr/bin/env bash
# Change TV To HDMI Input 3
echo "tx 4F:82:30:00" | cec-client -s -d 1
