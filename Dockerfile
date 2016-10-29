FROM ruby:2.3

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY . /myapp

RUN useradd user
RUN chown user:user -R /myapp
USER user

EXPOSE 3000

VOLUME /myapp/public/assets
