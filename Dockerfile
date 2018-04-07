FROM ruby:2.4

RUN apt-get update \
  && apt-get install -y \
    git \
    locales \
    make \
    nodejs

COPY . /src/gh/pages-gem

RUN \
  bundle config local.github-pages /src/gh/pages-gem && \
  bundle install --gemfile=/src/gh/pages-gem/Gemfile

RUN \
  echo "en_US UTF-8" > /etc/locale.gen && \
  locale-gen en-US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

WORKDIR /src/site

CMD ["jekyll", "serve", "-H", "0.0.0.0", "-P", "4000"]
