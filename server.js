var express = require('express'),
app = express(),
port = process.env.PORT || 80,
mongoose = require('mongoose'),
User = require('./api/models/user'),
Verife=Email = require('./api/models/email'),
bodyParser = require('body-parser');

// mongoose instance connection url connection
mongoose.Promise = global.Promise;
mongoose.connect('mongodb://kukuhkr:8720rumah@ds161183.mlab.com:61183/kkr'); 


app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


var routes = require('./api/routes/index'); //importing route
routes(app); //register the route


app.listen(port);


console.log('RESTful API server started on: ' + port);
