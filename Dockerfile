# Development stage
FROM node:lts-alpine as builder

WORKDIR /usr/src/app/

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Production stage
FROM nginx:stable-alpine

COPY --from=builder /usr/src/app/dist/poppap /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]