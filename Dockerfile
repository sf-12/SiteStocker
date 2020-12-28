FROM ruby:2.6.3
ENV TZ=Asia/Tokyo

RUN apt-get update
RUN apt-get install -y \
    default-mysql-client

WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN bundle install