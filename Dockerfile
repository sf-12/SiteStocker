FROM ruby:2.7.1
ENV TZ=Asia/Tokyo

RUN apt-get update \
    install -y \
    default-mysql-client \
    nodejs

WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN bundle install
