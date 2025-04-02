# Use an official Node.js image as a build stage
FROM node:18 AS build-stage

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Angular app
RUN npm run build -- --output-path=dist

# Use an official Nginx image to serve the app
FROM nginx:alpine

# Copy built Angular files to Nginx directory
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 8080

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
