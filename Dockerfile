FROM ruby:2.7.1
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y \
    default-mysql-client \
    nodejs

# yarnのインストールに必要
# https://classic.yarnpkg.com/en/docs/install/#debian-stable
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y \
    yarn

# System Spec用にgoogle chromeを導入
RUN sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y google-chrome-stable

WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN sh -c 'bundle install && bundle exec rails webpacker:install && bundle exec rails webpacker:install:react && bundle exec rails generate react:install'
