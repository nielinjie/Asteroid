define [\items/item,\version,\underscore,\util,\jquery] (its,version,_,util,$)->

  pool = (init)->
    _pool= void
    re= ->
      if not _pool? then
        _pool:=init()
      version.firstByVersionForAll _pool
    re.del= ->
      _pool:=void
    re.reload = ->
      _pool:=init()
    re

  status= ->
    items: items!.length
    meta: 307
    keys: users!.length

  items= pool (-> util.get \/items)

  item=(id)->
    _(items!).find ->
      it.id==id

  setMe = (user) ->
    users.del!
    meUser=me!
    meUser.name <<< user.name
    meUser <<< _(user).omit \name
    util.put \/me meUser
    me.del!

  me= util.memorize ->
    util.get \/me

  users = pool ->
     (util.get \/users)
  user = (id)->
    _(users!).find ->
      it.id==id

  friends= ->
    users! .filter ->
      it.id != me!.id

  friend= (id)->
    _(friends!).find ->
      it.id==id

  postItem= (item) ->
    items.del!
    util.post \/items item

  itemByUser=(userId) ->
    _(items!).filter ->
      it.author == userId


  refresh = ->
    users.del!
    items.del!
    me.del!

  findItem=  (where) ->
    #FIXME go to repository
    _(items!).where where

  {status,items,item,me,setMe,friends,friend,postItem,findItem,users,user,itemByUser,refresh}