require! nedb



db={}
db.items=new nedb do
  filename:"./data/items"
  autoload:true
db.items.ensureIndex do
  fieldname: \id
  unique: true
db.users=new nedb do
  filename:"./data/users"
  autoload:true
db.users.ensureIndex do
  fieldname: \id
  unique: true
#db.friends=new nedb("./data/friends");

exports.items= db.items
exports.users= db.users

