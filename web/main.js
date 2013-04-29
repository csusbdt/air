var connect = require('connect');
var port = process.env.PORT;
if (port === undefined) port = 5000;
connect.createServer(connect.static('web/public')).listen(port);

