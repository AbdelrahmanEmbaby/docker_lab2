# Step 1: Build frontend
FROM node:18 AS builder
WORKDIR /app
COPY client/package*.json ./client/
RUN cd client && npm install
COPY client ./client
RUN cd client && npm run build

# Step 2: Build backend
FROM node:18
WORKDIR /app
COPY server/package*.json ./server/
RUN cd server && npm install
COPY server ./server
COPY --from=builder /app/client/dist ./client/dist

WORKDIR /app/server
EXPOSE 3000
CMD ["npm", "start"]
