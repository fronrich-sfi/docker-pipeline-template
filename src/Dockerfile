# Stage 1: Build the React app
FROM node:18-alpine AS build
WORKDIR /app

# Leverage caching by installing dependencies first
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

# Copy the rest of the application code and build for production
COPY . ./
RUN npm run build


# Stage 2: Production environment
FROM nginx:alpine AS production

# Copy the production build artifacts from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Use nginx conf file to route request to index.html 
RUN rm /etc/nginx/conf.d/default.conf  
COPY nginx.conf /etc/nginx/conf.d

# Expose the default NGINX port
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]