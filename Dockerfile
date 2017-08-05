FROM ruby:2.4

RUN apt-get update \
  && apt-get install -y \
    git \
    make

COPY . /usr/src/app

WORKDIR /usr/src/app

RUN gem build github-pages.gemspec

CMD bundle install --gemfile=github-pages-127.gem
