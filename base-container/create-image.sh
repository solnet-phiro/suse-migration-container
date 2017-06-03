#!/usr/bin/env bash
echo "Building phiro/suse-base:$(date +%Y%m%d)"

docker build -t phiro/suse-base:$(date +%Y%m%d) .
