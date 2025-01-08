# Use Node.js 18 as the base image (ensure compatibility with JSReport)
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install

# Install Puppeteer dependencies (required for PDF generation)
RUN apt-get update && apt-get install -y \
    libnss3 \
    libxss1 \
    libasound2 \
    fonts-liberation \
    libappindicator3-1 \
    libgbm1 && \
    rm -rf /var/lib/apt/lists/*

# Copy remaining project files
COPY . .

# Pre-install Puppeteer binaries
RUN npx puppeteer install

# Expose port for JSReport
EXPOSE 5488

# Create and switch to a non-root user
RUN useradd -m appuser

# Ensure the appuser has permissions to the /app directory
RUN chown -R appuser:appuser /app

USER appuser

# Run the JSReport app
CMD ["npm", "start"]
