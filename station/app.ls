require! \express
_ =require \underscore
app=express()
app.use(express.bodyParser())

require! \./db.js

app.get \/items (req,res)->
  db.items.find {}, (err,data)->
    res.type \text/json
    res.send data
app.get \/items/idv (req,res)->
  db.items.find {}, (err,data)->
    res.type \text/json
    res.send _(data).map ->
      [it.id, it.version.name]

app.get \/users (req,res)->
  q=req.query? {}
  db.users.find q, (err,data)->
    res.type \text/json
    res.send data
app.get \/users/idv (req,res)->
  db.users.find {}, (err,data)->
    res.type \text/json
    res.send _(data).map ->
      [it.id, it.version.name]

app.post \/items (req,res)->
  item=req.body
  db.items.insert item, ->
    res.status 201 .send item.id

app.post \/users (req,res)->
  user=req.body
  console.log user
  db.users.insert user, ->
    res.status 201 .send user.id



app.listen(process.env.PORT || 4731);