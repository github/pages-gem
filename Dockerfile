FROM ruby:2.4

RUN apt-get update \
  && apt-get install -y \
    git \
    make

COPY . /gh-pages
WORKDIR /gh-pages

RUN bundle config local.github-pages /gh-pages
RUN bundle install

WORKDIR /site

CMD ["jekyll", "serve", "-H", "0.0.0.0", "-P", "4000"]
