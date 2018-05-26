#!/bin/sh
set -eu

down() {
    echo
    echo "clean up containers..."

    docker-compose down

    echo "done."
    echo
}

trap down HUP TERM INT;

if [ ! -d "./app" ]; then
    docker-compose -f ./docker/docker-compose.yml run --rm rails rails new . -f -d mysql --skip-turbolinks --skip-test
    cp -R ./docker/rails/init/.bundle ./.bundle
    docker-compose -f ./docker/docker-compose.yml run --rm rails bundle install
    cp ./docker/rails/init/puma.rb ./config/puma.rb
    cp ./docker/rails/init/database.yml ./config/database.yml
    docker-compose run -f ./docker/docker-compose.yml --rm rails rake db:create
fi

docker-compose -f ./docker/docker-compose.yml run --rm rails bundle install
docker-compose -f ./docker/docker-compose.yml up