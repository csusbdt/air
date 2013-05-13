// To set up for running this web server, do the following if not already done.
//
// (1) Install nodejs.
// (2) Run "npm install connect" to install the connect module and dependencies.
//
// Put files to be served in the public folder.
//
// Do the following to run the webserver.
//
//    node main.js
//

var connect = require('connect');
var port = process.env.PORT;
if (port === undefined) port = 5000;
connect.createServer(connect.static('public')).listen(port, function(err) {
  if (err) console.log(err.message);
  else console.log('Listenning on port 5000.');
});

