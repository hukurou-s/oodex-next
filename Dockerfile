FROM ruby:2.4.2

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs apt-transport-https && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt-get update -qq && apt-get install -y yarn && apt-get clean

RUN mkdir /app
WORKDIR /app
ENV RAILS_ENV production

COPY Gemfile Gemfile.lock yarn.lock package.json /app/
RUN bundle install -j4
RUN yarn

COPY . /app

RUN bundle exec rake assets:precompile
RUN mkdir -p /app/tmp/sockets && mkdir -p /app/tmp/pids

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
