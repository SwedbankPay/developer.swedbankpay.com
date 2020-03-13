FROM jekyll/jekyll:3.8

WORKDIR /home/jekyll
COPY . /home/jekyll

RUN gem install bundler
RUN apk --no-cache add \
  graphviz \
  openjdk8-jre-base

EXPOSE 4000
EXPOSE 35729

RUN chmod +x docker-startup.sh
ENTRYPOINT [ "./docker-startup.sh" ]

CMD [ "bundle", "exec", "jekyll", "serve", "--force_polling","--livereload", "--host", "0.0.0.0", "-i"]