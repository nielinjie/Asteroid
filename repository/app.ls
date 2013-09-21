require! \express
require! \./version.js
app=express()
app.use(\/public express.static('\../public'))
app.use(express.bodyParser())

require! \./db.js

app.get \/items (req,res)->
  db.items.find {}, (err,data)->
    res.type \text/json
    res.send data

app.get \/users (req,res)->
  db.users.find {}, (err,data)->
    res.type \text/json
    res.send data

app.post \/items (req,res)->
  item=req.body
  item.version=version.plus!
  db.items.findOne {id:item.id}, (err,data)->
    if data then
      res.status 409 .send 'item exsited'
  db.items.insert item, ->
    res.status 201 .send item.id

app.get \/me (req,res) ->
  db.me.findOne {} , (err,data)->
    if err then throw err
    db.users.find {id:data.user_id}, (err,data)->
      res.type \text/json
      res.send version.firstByVersion(data)

app.put \/me (req,res) ->
  user=req.body
#  console.log user.version
  user.version=version.plus(user.version)
  db.users.insert user, ->
    res.status 200 .send user.id


app.listen(process.env.PORT || 4730);