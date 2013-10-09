// Generated by LiveScript 1.2.0
(function(){
  var express, version, sync, app, db;
  express = require('express');
  version = require('./version.js');
  sync = require('./sync.js');
  app = express();
  app.use('/public', express['static']('../public'));
  app.use(express.bodyParser());
  db = require('./db.js');
  app.get('/items', function(req, res){
    return db.items.find({}, function(err, data){
      res.type('text/json');
      return res.send(data);
    });
  });
  app.get('/users', function(req, res){
    return db.users.find({}, function(err, data){
      res.type('text/json');
      return res.send(data);
    });
  });
  app.post('/items', function(req, res){
    var item;
    item = req.body;
    item.version = version.plus();
    db.items.findOne({
      id: item.id
    }, function(err, data){
      if (data) {
        return res.status(409).send('item exsited');
      }
    });
    return db.items.insert(item, function(){
      return res.status(201).send(item.id);
    });
  });
  app.get('/me', function(req, res){
    return db.me.findOne({}, function(err, data){
      if (err) {
        throw err;
      }
      return db.users.find({
        id: data.user_id
      }, function(err, data){
        res.type('text/json');
        return res.send(version.firstByVersion(data));
      });
    });
  });
  app.put('/me', function(req, res){
    var user;
    user = req.body;
    user.version = version.plus(user.version);
    return db.users.insert(user, function(){
      return res.status(200).send(user.id);
    });
  });
  app.get('/sync', function(req, res){
    sync.sync({
      url: 'http://localhost:4731'
    });
    return res.status(200).send('');
  });
  app.listen(process.env.PORT || 4730);
}).call(this);
