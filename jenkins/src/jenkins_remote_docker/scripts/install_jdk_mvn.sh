#!/bin/bash

echo 'deb http://ftp.debian.org/debian stretch-backports main' | sudo tee /etc/apt/sources.list.d/stretch-backports.list

apt-get update && apt-get install -y openjdk-11-jdk && apt-get install -y maven

