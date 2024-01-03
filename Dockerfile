ARG RUBY_VERSION=3.2
FROM ruby:$RUBY_VERSION

RUN apt-get update \
  && apt-get install -y \
    git \
    locales \
    make \
    nodejs

# final version for rubygems-update to supoprt ruby 2.7, consider removing this after upgraded to ruby 3.0
RUN gem update --system

COPY .git /src/gh/pages-gem/.git
COPY Gemfile* /src/gh/pages-gem/
COPY github-pages.gemspec /src/gh/pages-gem
COPY lib/ /src/gh/pages-gem/lib
COPY bin/ /src/gh/pages-gem/bin

RUN \
  bundle config local.github-pages /src/gh/pages-gem && \
  NOKOGIRI_USE_SYSTEM_LIBRARIES=true bundle install --gemfile=/src/gh/pages-gem/Gemfile

COPY . /src/gh/pages-gem

RUN \
  echo "en_US UTF-8" > /etc/locale.gen && \
  locale-gen en-US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

WORKDIR /src/site

CMD ["jekyll", "serve", "-H", "0.0.0.0", "-P", "4000"]
