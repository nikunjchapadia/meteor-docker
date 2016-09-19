# get node from official image - version 4.5.0
FROM node:4.5.0
MAINTAINER Nikunj Chapadia <nikunjchapadia@gmail.com>

ONBUILD WORKDIR /appsrc
ONBUILD COPY . /appsrc

# install meteor , build app , remove app source , remove meteor
ONBUILD RUN curl https://install.meteor.com/ | sh && \
    meteor build ../app --directory --architecture os.linux.x86_64 && \
    rm -rf /appsrc
# remove meteor

ONBUILD WORKDIR /app/bundle

# install npm packages
ONBUILD RUN (cd programs/server && npm install)
# expose port
EXPOSE 8080
CMD []
ENV PORT 8080
ENTRYPOINT MONGO_URL=mongodb://$MONGO_SERVICE_HOST:$MONGO_SERVICE_PORT /usr/local/bin/node main.js
