FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /tmp

RUN touch /etc/app-env

#RUN wget https://github.com/TracksApp/tracks/archive/v2.4.2.zip
#RUN unzip v2.4.2.zip

WORKDIR /app
RUN git clone https://github.com/TracksApp/tracks.git .
#RUN ls -la /app
#RUN ls -la /app/tracks
#RUN ls -la /tmp/tracks-2.4.2 /app
#RUN ls -la /tmp/tracks-2.4.2/Gemfile*
#RUN cp /tmp/tracks-2.4.2/Gemfile* /app
#WORKDIR /app

RUN gem update --system
RUN gem install bundler
RUN bundler update --bundler
RUN bundle config git.allow_insecure true
RUN bundle install

#RUN mkdir /app/log

#RUN cp -r /tmp/tracks-2.4.2/* /app
#COPY database_mysql.yml /app/config/database.yml
COPY database.yml /app/config/database.yml
COPY site.yml /app/config
COPY start.sh /app
#RUN rm -rf /tmp/v.2.4.2.zip /tmp/tracks-2.4.2

EXPOSE 3000

RUN bundle exec rake db:migrate RAILS_ENV=production
RUN bundle exec rake assets:precompile RAILS_ENV=production
#CMD ["bundle exec rails server -e production"]
CMD /app/start.sh
