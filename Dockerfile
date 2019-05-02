FROM ruby:2.4

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /bank
WORKDIR /bank

RUN gem update --system && gem install bundler

COPY bank/Gemfile /bank/Gemfile
COPY bank/Gemfile.lock /bank/Gemfile.lock
RUN bundle install
COPY bank/. /bank

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]