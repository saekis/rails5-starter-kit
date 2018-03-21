#!/bin/sh
set -eu

DATABASE=mysql

echo "\nCurrent ruby version: `rbenv version`\n"
ruby -v

echo "\nInstalling rails...\n"
gem install bundler
bundle install --path vendor/bundle --jobs=4

echo "\nRails new...\n"
bundle exec rails new . -f -d $DATABASE --skip-turbolinks --skip-test
