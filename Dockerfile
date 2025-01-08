# Base image with Node.js
FROM node:14

# Set working directory
WORKDIR /app

# Copy app files
COPY . .

# Install dependencies
RUN npm install

# Install Puppeteer dependencies
RUN apt-get update && apt-get install -y \
    libnss3 \
    libxss1 \
    libasound2 \
    fonts-liberation \
    libappindicator3-1 \
    libgbm1 && \
    rm -rf /var/lib/apt/lists/*

# Expose JSReport port
EXPOSE 5488

# Start JSReport
CMD ["npm", "start"]
