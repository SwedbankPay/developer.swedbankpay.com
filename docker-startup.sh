#!/bin/bash
set -e
echo "Set bundle config"
command bundle config set path '/usr/local/bundle'
echo "Install gems"
command bundle install
echo "Do the things"
exec $@