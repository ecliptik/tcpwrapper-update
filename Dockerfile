FROM ruby:3-slim
LABEL maintainer="Micheal Waltz <docker@ecliptik.com>"

#Copy Gemfile for gem install
WORKDIR /app
COPY Gemfile /app

#Intall packages
RUN apt-get update && apt-get install -y \
        ca-certificates \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        zlib1g-dev
RUN bundle install

#Copy the app after building gems
COPY . /app

#Rack port
EXPOSE 9292

#App command
ENTRYPOINT ["bundle"]
CMD ["exec", "rackup", "-o", "0.0.0.0"]
