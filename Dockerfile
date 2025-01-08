# Use official Node.js image as a base image
FROM node:20

# Install additional libraries (including those needed by Puppeteer and jsreport-pdf)
RUN apt-get update && apt-get install -y \
  libxss1 \
  libappindicator3-1 \
  libdrm2 \
  libgbm1 \
  libx11-xcb1 \
  libnss3 \
  libgdk-pixbuf2.0-0 \
  libatspi2.0-0 \
  lsb-release \
  xdg-utils \
  wget \
  ca-certificates \
  fonts-liberation \
  libgtk-3-0 \
  chromium \
  --no-install-recommends

# Add a non-root user
RUN useradd -m nodeuser

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./ 
RUN npm install

# Copy the rest of your application
COPY . ./

# Change ownership of the working directory to the non-root user
RUN chown -R nodeuser:nodeuser /app

# Switch to the non-root user
USER nodeuser

# Expose the port and run the application
EXPOSE 5488

# Set the environment variable to use the installed Chromium executable
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Run the application
CMD ["node", "server.js"]
