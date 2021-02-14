FROM ruby:2.7.2-slim

ENV BUNDLE_PATH="/config/bundle" \
    BUNDLE_BIN="/config/bundle/bin" \
    BUNDLE_APP_CONFIG="/config/bundle" \
    PATH="/app/bin:/config/bundle/bin:${PATH}" \
    HISTFILE="/config/.bash_history"

RUN apt-get update
RUN apt-get install -y --no-install-recommends --no-install-suggests \
            build-essential libsqlite3-dev git imagemagick curl nano

RUN mkdir -p /usr/local/nvm
ENV NVM_DIR="/usr/local/nvm" \
    NODE_VERSION="12.18.0"
RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# install node and npm
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install --global yarn

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


RUN gem update --system && gem install bundler

WORKDIR /app
EXPOSE ${PORT}
CMD "bash"
