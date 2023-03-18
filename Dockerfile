FROM node:14.18.3-alpine as build-step
ARG DEFAULT_PORT=3000
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . .
RUN npm run build
ENV PORT $DEFAULT_PORT
EXPOSE $PORT
CMD ["npm", "run", "start"]

