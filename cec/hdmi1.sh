#!/usr/bin/env bash
# Change TV to HDMI Input 1.

echo "tx 4F:82:10:00" | cec-client -s -d 1
