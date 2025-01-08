# Use Node.js 18 as the base image (ensure compatibility with JSReport)
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

USER root


# Install dependencies
RUN npm install

# Expose port for JSReport
EXPOSE 5488

# Run the JSReport app
CMD ["npm", "start"]
