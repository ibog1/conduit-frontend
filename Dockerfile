FROM node:20.9.0 AS build
WORKDIR /app
COPY . $WORKDIR
ARG API_URL  # docker-compose ARG
RUN npm install -g yarn --force && yarn install && node set-env.js && yarn build

FROM nginx:1.26.2-alpine
COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html
EXPOSE 80
