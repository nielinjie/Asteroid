require! \./dummy/dummyText.js
require! \./dummy/dummyUsers.js
require! \./db.js
require! \async
require! \uuid
require! \./util.js
require! \./version.js

_ = require \underscore

users=_.chain(dummyUsers.users) .pluck \user .map ->
  it.id=it.sha1_hash
  it.memo=''
  it.version=version.plus!
  it
.value!

items=_(dummyText.texts).map ->
  id:uuid.v4!
  text:it
  author:users[util.random(users.length-1)].id
  date: new Date()
  version: version.plus!
db.items.remove {}, { multi: true }, (err,data)->
  if err then throw err
  async.each items, ->
    db.items.insert &0
    &1!



db.users.remove {}, { multi: true }, (err,data)->
  if err then throw err
  async.each users, ->
    db.users.insert &0
    &1!

db.me.remove {} (err,data) ->
  if err then throw err
  db.me.insert {
    user_id:users[0].id
  }