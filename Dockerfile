###########
# BUILDER #
###########

# pull official base image
FROM node:14-alpine as builder

# set work directory
WORKDIR /usr/src/app

# install dependencies postgresql
RUN apk update \
    && apk add postgresql-dev
COPY package.json .
COPY yarn.lock .

#########
# FINAL #
#########

# pull official base image
FROM node:14-alpine

# create directory for the app user
RUN mkdir -p /home/app

# create the app user
RUN addgroup -S app && adduser -S app -G app

# create the appropriate directories
ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# install dependencies
RUN apk update && apk add libpq
COPY --from=builder /usr/src/app/package.json .
COPY --from=builder /usr/src/app/yarn.lock .
RUN yarn install --frozen-lockfile

# copy project
COPY . $APP_HOME

ENV NODE_ENV development

# chown all the files to the app user
RUN chown -R app:app $APP_HOME

# change to the app user
USER app

RUN yarn build

EXPOSE 1337

CMD ["yarn", "develop"]