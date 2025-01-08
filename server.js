const jsreport = require('jsreport')()
const puppeteer = require('puppeteer-core')

// Path to Chromium installed in the Docker container
const chromiumExecutablePath = process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/chromium'

if (process.env.JSREPORT_CLI) {
  // Export jsreport instance to make it possible to use jsreport-cli
  module.exports = jsreport
} else {
  jsreport.init()
    .then(() => {
      // Initialize Puppeteer with no-sandbox flag and additional arguments
      puppeteer.launch({
        executablePath: chromiumExecutablePath,
        args: [
          '--no-sandbox', 
          '--disable-setuid-sandbox', 
          '--headless', 
          '--disable-gpu', 
          '--disable-software-rasterizer', 
          '--no-zygote'
        ]
      })
        .then(browser => {
          console.log('Browser launched successfully');
        })
        .catch(err => {
          console.error('Error launching browser:', err);
        });

      console.log('Jsreport is up and running...');
    })
    .catch((e) => {
      // Error during startup
      console.error(e.stack)
      process.exit(1)
    })
}
