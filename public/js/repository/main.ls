define [\items/item,\underscore,\util,\jquery] (its,_,util,$)->



  status= ->
    items: items!.length
    meta: 307
    keys: users!.length

  items= util.memorize ->
    _items=[]
    $ .ajax \/items ,
      {async:false,dataType:\json}
    .done ->
      _items:=it
    _items
  item=(id)->
    _(items!).find ->
      it.id==id

  me= ->
    users! .0

  users = util.memorize ->
    _users=[]
    $ .ajax \/users ,
    {async:false,dataType:\json}
    .done ->
      _users:=it
    _users

  friends=users

  friend= (id)->
    _(users!).find ->
      it.id==id

  postItem= (item) ->
    items.del!
#    users.del!
    $ .ajax \/items , do
      async:false
      type:\POST
      data: item
      dataType: \json


  findItem=  (where) ->
    #FIXME go to repository
    _(items!).where where

  {status,items,item,me,friends,friend,postItem,findItem}