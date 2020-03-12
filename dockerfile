FROM ruby:2.7

COPY . /srv/jekyll
WORKDIR /srv/jekyll

RUN gem install bundler
RUN apt-get update && apt-get install -y \
  libfontconfig \
  graphviz \
  gcc \
  bash \
  cmake \
  git \
  default-jre


RUN bundle install

EXPOSE 4000
EXPOSE 35729

ENTRYPOINT [ "bundle", "exec", "jekyll", "serve" ]

CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling","--livereload", "--host", "0.0.0.0"]