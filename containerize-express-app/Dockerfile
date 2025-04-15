FROM node:20.14.0

WORKDIR /app

#Copy Dependencies package-lock.json package.json
COPY package*.json .


#Install Dependencies
RUN npm ci

#Copy Source Code
COPY src/index.js index.js

#Expose the application port
EXPOSE 3000

#Start application
CMD ["node", "index.js"]