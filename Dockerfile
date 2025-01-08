# Use Node.js as base image
FROM node:14

# Set working directory
WORKDIR /app

# Copy project files
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

# Expose port for JSReport
EXPOSE 5488

# Run the JSReport app
CMD ["npm", "start"]
