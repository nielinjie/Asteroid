require! \express
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
  db.items.insert item, ->
    res.status 201 .send item.id




app.listen(process.env.PORT || 4730);