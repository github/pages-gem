# The github-pages function optionally takes two arguments
#  - the first argument is the path to the Jekyll site
#  - the second argument is the port number
function github-pages {
  _path=${1:-.}
  _port=${2:-4000}
  docker run --rm -v `realpath $_path`:/src/site -p $_port:4000 gh-pages
}
