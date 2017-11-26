FROM ruby:2.4

RUN apt-get update \
  && apt-get install -y \
    git \
    make

COPY . /src/gh/pages-gem

RUN \
  bundle config local.github-pages /src/gh/pages-gem && \
  bundle install --gemfile=/src/gh/pages-gem/Gemfile

WORKDIR /site

CMD ["jekyll", "serve", "-H", "0.0.0.0", "-P", "4000"]
