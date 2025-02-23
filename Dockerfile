FROM jrottenberg/ffmpeg:4.1-alpine AS ffmpeg

FROM node:16-alpine
COPY --from=ffmpeg / /

WORKDIR /app

COPY package.json ./
COPY yarn.lock ./
RUN apk add --no-cache --virtual .build-deps alpine-sdk python2 &&\
    yarn install --production &&\
    apk del .build-deps

COPY build/ ./
CMD [ "node", "index.js" ]
