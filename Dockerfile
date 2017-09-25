FROM ruby:2.4-alpine
MAINTAINER Micheal Waltz <ecliptik@gmail.com>

#Copy Gemfile for gem install
WORKDIR /app
COPY Gemfile /app

#Intall packages
RUN apk --no-cache add \
        --virtual build-dependencies \
        build-base \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        ruby-dev \
        zlib-dev && \
    apk --no-cache add \
        ca-certificates && \
    bundle install && \
    apk del build-dependencies

#Copy the app after building gems
COPY . /app

#Rack port
EXPOSE 9292

#App command
ENTRYPOINT ["bundle"]
CMD ["exec", "rackup", "-o", "0.0.0.0"]
