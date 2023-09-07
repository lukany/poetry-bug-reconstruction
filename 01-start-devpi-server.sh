#!/bin/bash

# See https://devpi.net/docs/devpi/devpi/latest/+doc/quickstart-releaseprocess.html#initializing-a-basic-server-and-index


if [ -f supervisord.pid ]; then
    kill "$(cat supervisord.pid)"
    rm supervisord.pid
fi
rm -rf .devpi
devpi-init --serverdir .devpi/server
devpi-gen-config --serverdir .devpi/server
supervisord -c gen-config/supervisord.conf
echo "Waiting for devpi-server to start..."
sleep 10
devpi use http://localhost:3141
devpi user -c testuser password=123
devpi login testuser --password=123
devpi index -c dev bases=root/pypi
devpi use testuser/dev
