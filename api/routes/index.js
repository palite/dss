'use strict';

module.exports = function(app) {
  var control = require('../controllers/oauth.js');

  // todoList Routes
  app.route('/signup')
    .post(control.signUp);
    app.route('/login')
    .post(control.logIn);
    app.route('/verif')
    .post(control.verifEmail); 
  app.route('/verif/:code')
    .get(control.confirm);
  }


  