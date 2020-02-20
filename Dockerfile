FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

#COPY Gemfile Gemfile.lock ./
#RUN bundle install
RUN wget https://github.com/TracksApp/tracks/archive/v2.4.1.zip
RUN unzip v2.4.1.zip

WORKDIR /usr/src/app/tracks-2.4.1

RUN gem update --system
RUN gem install bundler
RUN bundler update --bundler
RUN bundle install

COPY . .

#CMD ["./your-daemon-or-script.rb"]
CMD ["/usr/src/app/tracks-2.4.1/config.rb"]

EXPOSE 80/tcp
