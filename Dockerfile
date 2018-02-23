FROM ruby:2.2.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y npm && \
  ln -s /usr/bin/nodejs /usr/bin/node && \
  npm install -g phantomjs
RUN mkdir /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
WORKDIR /app
RUN bundle install -j `nproc`
COPY . /app
