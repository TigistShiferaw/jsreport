# Use official Node.js image
FROM node:20

# Set the working directory
WORKDIR /app

# Install required dependencies
RUN npm install -g jsreport

# Install Puppeteer explicitly
RUN npm install puppeteer --save

# Install jsReport with templates
COPY package*.json ./
RUN npm install

# Copy your custom templates and assets (if you have any)

# Expose jsReport port
EXPOSE 5488

# Start jsReport
CMD ["jsreport", "start"]
