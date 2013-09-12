// Generated by LiveScript 1.2.0
(function(){
  var dummyText, dummyUsers, db, async, uuid, util, _, users, items;
  dummyText = require('./dummy/dummyText.js');
  dummyUsers = require('./dummy/dummyUsers.js');
  db = require('./db.js');
  async = require('async');
  uuid = require('uuid');
  util = require('./util.js');
  _ = require('underscore');
  users = _.chain(dummyUsers.users).pluck('user').map(function(it){
    it.id = it.sha1_hash;
    return it;
  }).value();
  items = _(dummyText.texts).map(function(it){
    return {
      id: uuid.v4(),
      text: it,
      author: users[util.random(users.length - 1)].id,
      date: new Date(),
      version: 1
    };
  });
  db.items.remove({}, {
    multi: true
  }, function(err, data){
    if (err) {
      throw err;
    }
    return async.each(items, function(){
      db.items.insert(arguments[0]);
      return arguments[1]();
    });
  });
  db.users.remove({}, {
    multi: true
  }, function(err, data){
    if (err) {
      throw err;
    }
    return async.each(users, function(){
      db.users.insert(arguments[0]);
      return arguments[1]();
    });
  });
}).call(this);
