// Generated by LiveScript 1.2.0
(function(){
  define(['text!./dummy.txt', 'underscore', 'util'], function(te, _, util){
    return _.chain(te.split('\n')).map(function(it){
      return it.trim();
    }).filter(function(it){
      return it !== '';
    }).map(function(it){
      return it.slice(1, util.random(140));
    }).shuffle().value();
  });
}).call(this);