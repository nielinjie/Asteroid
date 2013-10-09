require! nedb



db={}
if (not process.argv[0]=='data=memory') then
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
  db.me= new nedb do
    filename:"./data/me"
    autoload:true
else
  db.items=new nedb do
    autoload:true
  db.items.ensureIndex do
    unique: true
  db.users=new nedb do
    autoload:true
  db.users.ensureIndex do
    unique: true
  db.me= new nedb do
    autoload:true

#db.friends=new nedb("./data/friends");

exports.items= db.items
exports.users= db.users
exports.me= db.me

