define [\items/item,\version,\underscore,\util,\jquery] (its,version,_,util,$)->
  refresh = ->

  get=(url) ->
    _re=[]
    $ .ajax url ,
      {async:false,dataType:\json}
    .done ->
      _re:=it
    _re
  post=(url, data) ->
    $ .ajax url , do
      async:false
      type:\POST
      data: data
      dataType: \json

  put=(url, data) ->
    $ .ajax url , do
      async:false
      type:\PUT
      data: data
      dataType: \json

  status= ->
    items: items!.length
    meta: 307
    keys: users!.length

  items= util.memorize ->
    version.firstByVersionForAll (get \/items)

  item=(id)->
    _(items!).find ->
      it.id==id

  setMe = (user) ->
    users.del!
    meUser=me!
    meUser.name <<< user.name
    meUser <<< _(user).omit \name
    put \/me meUser
    me.del!

  me= util.memorize ->
    get \/me

  users = util.memorize ->
    version.firstByVersionForAll (get \/users)
  user = (id)->
    _(users!).find ->
      it.id==id

  friends= ->
    users! .filter ->
      it.id !== me!.id

  friend= (id)->
    _(friends!).find ->
      it.id==id

  postItem= (item) ->
    items.del!
    post \/items item




  findItem=  (where) ->
    #FIXME go to repository
    _(items!).where where

  {status,items,item,me,setMe,friends,friend,postItem,findItem,users,user}