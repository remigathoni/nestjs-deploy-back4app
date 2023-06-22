# Build
FROM node:20-alpine AS builds
WORKDIR /usr/src/app
COPY package*.json  ./
RUN npm install --only development
COPY . .
RUN npm run build

# Production
FROM node:20-alpine AS production
WORKDIR /usr/src/app
COPY package*.json  ./
RUN npm ci --only=production
COPY . .
COPY --from=build /usr/src/app/dist ./dist
RUN rm package*.json 
EXPOSE 3000/tcp
CMD [ "node", "dist/main.js" ]



