var connect = require('connect');
var port = process.env.PORT;
if (port === undefined) port = 5000;
connect.createServer(connect.static('public')).listen(port, function(err) {
  if (err) console.log(err.message);
  else console.log('Listenning on port 5000.');
});

