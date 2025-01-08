# Use Node.js 18 as the base image
FROM node:20 AS build-stage


# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies
RUN npm RUN npm ci


# Install Puppeteer dependencies
RUN apt-get update && apt-get install -y \
    libnss3 \
    libxss1 \
    libasound2 \
    fonts-liberation \
    libappindicator3-1 \
    libgbm1 && \
    rm -rf /var/lib/apt/lists/*

# Expose port for JSReport
EXPOSE 5488

# Run the JSReport app
CMD ["npm", "start"]
