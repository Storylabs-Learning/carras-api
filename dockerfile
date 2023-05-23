# BASE
FROM node:18-alpine3.17 as base
RUN apk add curl bash --no-cache
RUN curl -sf https://gobinaries.com/tj/node-prune | sh

# BUILD
FROM base as build
WORKDIR /app
COPY package.json .
COPY package-lock.json .

RUN npm install
RUN npm prune --production && node-prune

# RELEASE
FROM node:18-alpine3.17 as release
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json
COPY ./src ./src

EXPOSE 3000

# npm run dev ó node src/main.js
CMD node src/main.js