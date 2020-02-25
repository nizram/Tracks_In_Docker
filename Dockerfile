FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

#COPY Gemfile Gemfile.lock ./
#RUN bundle install
RUN wget https://github.com/TracksApp/tracks/archive/v2.4.2.zip
RUN unzip v2.4.2.zip

WORKDIR /app/tracks-2.4.2

RUN gem update --system
RUN gem install bundler
RUN bundler update --bundler
RUN bundle install

COPY . .
COPY database.yml /app/config

#CMD ["./your-daemon-or-script.rb"]
CMD ["/app/tracks-2.4.2/config.ru"]

EXPOSE 3000/tcp
