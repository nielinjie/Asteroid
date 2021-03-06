// Generated by LiveScript 1.2.0
(function(){
  var _, util, fs, data;
  _ = require('underscore');
  util = require('../util.js');
  fs = require('fs');
  data = fs.readFileSync(__dirname + "/dummy.txt", {
    encoding: 'utf8'
  });
  exports.texts = _.chain(data.split('\n')).map(function(it){
    return it.trim();
  }).filter(function(it){
    return it !== '';
  }).map(function(it){
    return it.slice(1, util.random(140));
  }).shuffle().value();
}).call(this);
