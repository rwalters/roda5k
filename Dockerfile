FROM ruby:2.4-slim

RUN apt-get update -qq && \
  apt-get install -y \
    build-essential \
    libpq-dev \
    libsqlite3-dev \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

ADD . /app/

RUN bundle install

CMD ruby app.rb -p 3000 -h 0.0.0.0
