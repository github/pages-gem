#!/usr/bin/env sh
# The github-pages function optionally reads two environment variables
#  - the first is the path to the Jekyll site (GH_PATH)
#  - the second is the port number (GH_PORT)

function github-pages {
  _path=${GH_PATH:-.}
  _port=${GH_PORT:-4000}
  docker run --rm \
    -p $_port:4000 \
    -u `id -u`:`id -g` \
    -v `realpath $_path`:/src/site \
    gh-pages jekyll serve -H 0.0.0.0 -P 4000 $@
}
