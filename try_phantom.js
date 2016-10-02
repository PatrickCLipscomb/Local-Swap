page = require('webpage').create()
page.open 'http://localhost:3000'.function(status) {
  console.log('status: ' + status)
  phantom.exit()
}
