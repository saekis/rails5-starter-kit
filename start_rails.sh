#!/bin/sh

RUBY_VERSION=2.5.0
DATABASE=mysql

## Set ruby version
rbenv local $RUBY_VERSION
ruby -v

gem install bundler
bundle install --path vendor/bundle --jobs=4

bundle exec rails new . -f -d $DATABASE --skip-turbolinks --skip-test
