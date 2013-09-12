define [\items/item,\underscore,\util,\jquery] (its,_,util,$)->
  users=[]
  $ .ajax \/users ,
  {async:false,dataType:\json}
  .done ->
    users:=it
  items=[]
  $ .ajax \/items ,
  {async:false,dataType:\json}
  .done ->
    items:=it

  status: ->
    items: 983
    meta: 307
    keys: 125
  items: ->
    items
  me: ->
    users[0]
  friends: ->
    users


  friend: (id)->
    _(users).find ->
      it.id==id

  postItem: (item) ->
    $ .ajax \/items , do
      async:true
      type:\POST
      data: item
      dataType: \json
    .done ->
      users.push(item)

