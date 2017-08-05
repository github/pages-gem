FROM ruby:2.4

RUN apt-get update \
  && apt-get install -y \
    git \
    make

COPY . /src
WORKDIR /src

RUN gem build github-pages.gemspec

CMD bundle install --gemfile=github-pages-127.gem
