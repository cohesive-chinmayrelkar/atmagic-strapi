from node:18.12.0

RUN mkdir /app

WORKDIR /app

COPY package.json /app
COPY yarn.lock /app

RUN yarn install

COPY . /app

RUN yarn run build

CMD yarn start
