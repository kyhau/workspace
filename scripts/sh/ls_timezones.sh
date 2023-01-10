#!/bin/bash

awk '/^Z/ { print $2 }; /^L/ { print $3 }' /usr/share/zoneinfo/tzdata.zi | sort
