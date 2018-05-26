#!/bin/sh
set -eu

down() {
    echo
    echo "clean up containers..."

    docker-compose -f ./docker/docker-compose.yml down

    echo "done."
    echo
}

trap down HUP TERM INT;

if [ ! -d "./app" ]; then
    docker-compose -f ./docker/docker-compose.yml run --rm rails rails new . -f -d mysql --skip-turbolinks --skip-test
    docker-compose -f ./docker/docker-compose.yml run --rm rails bundle install
    cp ./docker/rails/init/puma.rb ./config/puma.rb
    cp ./docker/rails/init/database.yml ./config/database.yml
    docker-compose -f ./docker/docker-compose.yml run --rm rails rake db:create
fi

docker-compose -f ./docker/docker-compose.yml run --rm rails bundle install
docker-compose -f ./docker/docker-compose.yml up