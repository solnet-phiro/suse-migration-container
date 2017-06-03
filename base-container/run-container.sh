#!/usr/bin/env bash

docker rm -f opensuse-migrator-base

docker run -d -p 2222:22 --name opensuse-migrator-base phiro/suse-base:20170603