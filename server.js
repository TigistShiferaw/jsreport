const puppeteer = require('puppeteer-core');
const chromiumExecutablePath = '/usr/bin/chromium';  // Path to Chromium installed in your Docker container

async function launchBrowser() {
    const browser = await puppeteer.launch({
        executablePath: chromiumExecutablePath,
        args: ['--no-sandbox', '--disable-setuid-sandbox'] // Pass the flags here
    });
    return browser;
}

launchBrowser()
  .then((browser) => {
    console.log('Browser launched');
    // Your code to generate the report...
  })
  .catch((err) => {
    console.error('Error launching browser:', err);
  });
