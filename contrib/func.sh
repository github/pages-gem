#!/usr/bin/env sh
# The github-pages function optionally takes two arguments
#  - the first argument is the path to the Jekyll site
#  - the second argument is the port number
function github-pages {
  _path=${1:-.}
  _port=${2:-4000}
  docker run --rm \
    -p $_port:4000 \
    -u `id -u`:`id -g` \
    -v `realpath $_path`:/src/site \
    gh-pages
}
