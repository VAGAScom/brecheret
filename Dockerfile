FROM ruby:2.6.1-alpine3.9

RUN apk update \
  && apk upgrade \
  && apk add --update \
  git \
  build-base \
  && rm -rf /var/cache/apk/*

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 2 --retry 1

COPY . .

ENTRYPOINT ["rake"]
