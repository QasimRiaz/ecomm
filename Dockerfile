# Build Stage
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Production Stage
FROM node:18-alpine

WORKDIR /app
COPY --from=builder /app /app
RUN npm install --production

EXPOSE 8080
ENV NODE_OPTIONS="--max-old-space-size=4096"
CMD ["npm", "run", "start"]
