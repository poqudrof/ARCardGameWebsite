FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN yarn install

# Copy disabled
# COPY . .

EXPOSE 3000