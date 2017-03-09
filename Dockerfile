FROM ruby:2.3.3-alpine

RUN mkdir /usr/src/app \
  && apk update \
  && apk upgrade \
  && apk add --no-cache bash git make

COPY . /usr/src/app

WORKDIR /usr/src/app

RUN gem build github-pages.gemspec

CMD bundle install --gemfile=github-pages-127.gem
