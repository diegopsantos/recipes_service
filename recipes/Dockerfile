FROM ruby:2.7.1-alpine

WORKDIR /recipes

RUN apk add --update --no-cache \
    build-base \
    libxml2-dev \
    libxslt-dev \
    tzdata && \
    gem install bundler --no-document && \
    rm -rf /var/cache/apk/*

COPY Gemfile* /recipes/

RUN bundle install && \
    rm -rf /var/cache/apk/*

COPY . /recipes

CMD ["puma", "config.ru", "-C", "puma.rb"]
