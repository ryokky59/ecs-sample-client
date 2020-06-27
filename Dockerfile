FROM node:12.18.1-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --quiet

COPY . .

RUN npm rebuild

RUN npm install vue-cli -g

RUN npm run build

ENV HOST 0.0.0.0

EXPOSE 3000

CMD ["npm", "run", "start"]
