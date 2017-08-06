DOCKER=docker

TAG=gh-pages

# Build the docker image
image:
	${DOCKER} build -t ${TAG} .

# Produce a bash shell
shell:
	${DOCKER} run --rm -it \
		-p 4000:4000 \
		-v ${PWD}:/gh-pages \
		${TAG} \
		/bin/bash

# Spawn a server. Specify the path to the SITE directory by
# exposing it using `expose SITE="../path-to-jekyll-site"` prior to calling or
# by prepending it to the make rule e.g.: `SITE=../path-to-site make server`
server:
	ls "${SITE}" >/dev/null && \
	${DOCKER} run --rm -it \
		-p 4000:4000 \
		-v ${PWD}:/gh-pages \
		-v `realpath ${SITE}`:/site \
		-w /site \
		${TAG}

.PHONY:
	image server shell
