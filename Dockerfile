FROM ruby:2.3.3-slim

RUN apt-get update -qq \
  && apt-get install -y \
    build-essential \
    libpq-dev \
    libsqlite3-dev \
  && apt-get clean autoclean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

ADD . /app/

RUN gem install bundler --no-document \
  && bundle install

EXPOSE 5000

CMD ["bundle", "exec", "unicorn", "-l 0.0.0.0:5000", "-E development"]
