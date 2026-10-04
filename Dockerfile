FROM node:22-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY server.js ./

ENV NODE_ENV=developer
EXPOSE 3000

CMD ["npm", "start"]