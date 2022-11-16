FROM ruby:3.1.2

# railsコンソール中で日本語入力するための設定
ENV LANG=C.UTF-8

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

# Bundlerの不具合対策
RUN gem update --system
RUN bundle update --bundler

RUN bundle install
ADD . /app

# Add a script to be executed every time the container starts.
ADD entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
