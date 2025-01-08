# Use official Node.js image
FROM node:20

# Set the working directory
WORKDIR /app

# Install required dependencies
RUN npm install -g jsreport

# Install Puppeteer explicitly
RUN npm install puppeteer --save

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy custom templates and assets (if you have any)
COPY ./templates /app/templates

# Expose jsReport port
EXPOSE 5488

# Start jsReport
CMD ["npm", "start"]
