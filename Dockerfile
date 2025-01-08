# Use Node.js 20 as the base image
FROM node:20

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install the latest npm version (compatible with Node.js 20)
RUN npm install -g npm@latest

# Install project dependencies
RUN npm install --legacy-peer-deps

# Install Puppeteer dependencies (required for PDF generation)
RUN apt-get update && apt-get install -y \
    libnss3 \
    libxss1 \
    libasound2 \
    fonts-liberation \
    libappindicator3-1 \
    libgbm1 && \
    rm -rf /var/lib/apt/lists/*

# Install Puppeteer
RUN npm install puppeteer@20.7.0
RUN node node_modules/puppeteer/install.js

# Ensure Puppeteer cache directory exists and is writable
RUN mkdir -p /home/appuser/.cache/puppeteer && chown -R appuser:appuser /home/appuser/.cache

# Copy remaining project files
COPY . .

# Expose port for JSReport
EXPOSE 5488

# Create and switch to a non-root user
RUN useradd -m appuser
USER appuser

# Run the JSReport app
CMD ["npm", "start"]
