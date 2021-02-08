FROM ruby:2.7.1
ENV TZ=Asia/Tokyo

RUN apt-get update
RUN apt-get install -y \
    default-mysql-client \
    nodejs

# System Spec用にgoogle chromeを導入
RUN sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y google-chrome-stable

WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN bundle install
