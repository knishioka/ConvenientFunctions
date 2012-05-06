#!/usr/bin/env bash
sudo apt-get -y update
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline5-dev libyaml-dev ruby1.9
sudo gem install chef ruby-shadow --no-ri --no-rdoc