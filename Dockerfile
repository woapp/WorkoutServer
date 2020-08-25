FROM elixir:1.10.4

ENV PHX_VERSION 1.5.4
ENV NODE_MAJOR 12

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN set -x &&\
  mix local.hex --force &&\
  mix local.rebar --force &&\
  mix archive.install hex phx_new $PHX_VERSION --force &&\
  curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash - &&\
  apt-get install -y nodejs inotify-tools