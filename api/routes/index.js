'use strict';

module.exports = function(app) {
  var control = require('../controllers/control.js');

  // todoList Routes
  app.route('/tes')
    .get(control.tes);
   
  }
  


  