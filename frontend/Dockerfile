# Build stage
FROM node:16 AS build-stage

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

ENV NODE_ENV=development
RUN npm run build:dll

ARG APP_VERSION
ENV VUE_APP_VERSION=$APP_VERSION

ARG SERVER_NAME
ENV SERVER_NAME=$SERVER_NAME

RUN npm run build

# Production stage
FROM nginx:stable-alpine AS production-stage

ENV SERVER_NAME="csep.seung.site"
WORKDIR /app
COPY ./ /app/
COPY --from=build-stage /app/dist /usr/share/nginx/html

RUN echo ${SERVER_NAME}
#COPY --from=build-stage /app/deploy/nginx /etc/nginx
#COPY --from=build-stage /app/deploy/entrypoint.sh /app/deploy/entrypoint.sh
RUN chmod -R u=rwX,go=rX ./
RUN chmod +x /app/deploy/entrypoint.sh
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["/app/deploy/entrypoint.sh"]
