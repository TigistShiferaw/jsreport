const jsreport = require('jsreport')()
const puppeteer = require('puppeteer-core')

// Path to Chromium installed in the Docker container
const chromiumExecutablePath = '/usr/bin/chromium'

if (process.env.JSREPORT_CLI) {
  // Export jsreport instance to make it possible to use jsreport-cli
  module.exports = jsreport
} else {
  jsreport.init()
    .then(() => {
      // Initialize Puppeteer with no-sandbox flag
      puppeteer.launch({
        executablePath: chromiumExecutablePath,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
      })
        .then(browser => {
          console.log('Browser launched');
          // You can add additional logic here for handling jsReport rendering if needed
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
