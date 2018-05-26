#!/bin/sh
set -eu

cd `dirname $0`

down() {
    echo
    echo "clean up containers..."

    docker-compose -f ./docker-compose.yml down

    echo "done."
    echo
}

trap down HUP TERM INT;

if [ ! -d "../app" ]; then
    pwd
    cp -R ./rails/init/.bundle ../.bundle
    cp ./rails/init/Gemfile ../Gemfile
    cp ./rails/init/Gemfile.lock ../Gemfile.lock
    docker-compose -f ./docker-compose.yml run --rm rails rails new . -f -d mysql --skip-turbolinks --skip-test
    docker-compose -f ./docker-compose.yml run --rm rails bundle install
    cp ./rails/init/puma.rb ../config/puma.rb
    cp ./rails/init/database.yml ../config/database.yml
    docker-compose -f ./docker-compose.yml run --rm rails rake db:create
fi

docker-compose -f ./docker-compose.yml run --rm rails bundle install
docker-compose -f ./docker-compose.yml up