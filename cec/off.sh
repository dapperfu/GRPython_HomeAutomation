#!/usr/bin/env bash
# Change TV to HDMI Input 1.

echo "standby 0.0.0.0" | cec-client -s -d 1
