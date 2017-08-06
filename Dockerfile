FROM ruby:2.4

RUN apt-get update \
  && apt-get install -y \
    git \
    make

COPY . /gh-pages
WORKDIR /gh-pages

RUN bundle config local.github-pages /gh-pages
RUN bundle install

CMD bundle install --gemfile=github-pages-127.gem
