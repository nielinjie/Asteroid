require! nedb



db={}
# db is in memory
db.items=new nedb do
  autoload:true
db.items.ensureIndex do
  fieldname: \id
  unique: true
db.users=new nedb do
  autoload:true
db.users.ensureIndex do
  fieldname: \id
  unique: true

db.me= new nedb do
  autoload:true

#db.friends=new nedb("./data/friends");

exports.items= db.items
exports.users= db.users
exports.me= db.me

