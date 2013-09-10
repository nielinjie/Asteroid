require! \express
app=express()

require! \./db.js

app.get \/ (req,res)->
  db.items (err,data)->
    res.type \text/json
    res.send data

app.listen(process.env.PORT || 4730);