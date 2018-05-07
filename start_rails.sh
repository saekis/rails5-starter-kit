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
    docker-compose run --rm rails rails new . -f -d mysql --skip-turbolinks --skip-test
    docker-compose run --rm rails bundle install
    cp ./docker/rails/init/puma.rb ./config/puma.rb
    cp ./docker/rails/init/database.yml ./config/database.yml
    docker-compose run --rm rails rake db:create
fi

docker-compose run --rm rails bundle install
docker-compose up