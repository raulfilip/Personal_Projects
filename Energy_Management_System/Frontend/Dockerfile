# Use a lightweight Node.js image as the base image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files first to leverage Docker's caching mechanism
COPY package.json package-lock.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Expose the port on which the app will run
EXPOSE 3000

# Set the environment variable to make npm start run in production mode
ENV NODE_ENV=production

# Run the React application
CMD ["npm", "start"]
