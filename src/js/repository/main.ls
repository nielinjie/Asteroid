define [\items/item,\./dummyText, \./dummyUsers, \underscore,\util] (its,duT,dU,_,util)->
  dummyUsers =_.chain(dU)
    .pluck \user
    .shuffle!
    .value!
  userNum=_(dummyUsers).size!
  dummyItems=_(duT).map ->
      its.newItem(it,dummyUsers[util.random(userNum)].sha1_hash)

  status: ->
    items: 983
    meta: 307
    keys: 125
  items: ->
    dummyItems
  me: ->
    dummyUsers[0]
  friends: ->
    dummyUsers
  item: (id)->
    _(dummyItems).find ->
      it.id==id
  friend: (id)->
    _(dummyUsers).find ->
      it.sha1_hash==id #FIXME