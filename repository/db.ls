require! nedb

db={}
db.items=new nedb do
  filename:"./data/items"
  autoload:true
#db.friends=new nedb("./data/friends");

exports.items= (cb)->
  db.items.find {} cb
