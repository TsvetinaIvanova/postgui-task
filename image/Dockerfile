FROM node:14-alpine
RUN apk update && apk add jq

RUN mkdir /postgui-app
COPY ./PostGUI/ /postgui-app/
WORKDIR /postgui-app

RUN npm install

CMD ["npm", "start"]