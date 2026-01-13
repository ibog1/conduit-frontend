FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .


ARG API_URL                           
ENV NG_APP_API_URL=$API_URL
RUN npm run build -- --configuration production 

FROM nginx:alpine
COPY --from=builder /app/dist/angular-conduit /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
