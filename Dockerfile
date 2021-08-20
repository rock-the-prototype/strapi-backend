FROM strapi/base:14

WORKDIR /my-path

COPY ./package.json ./
COPY ./yarn.lock ./

RUN yarn install

COPY . .

ENV NODE_ENV production

RUN yarn build