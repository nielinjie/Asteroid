define [\underscore] (_)->
  newer = (a,b) ->
    if (a.base?.length ? 0) >0  then
      _(a.base).any ->
        it.name == b.name or newer(it,b)
    else
      false

  newFirst = (a,b) ->
    if a.name==b.name then
      0
    else if newer(a,b) then
      -1
    else
      1
  firstByVersion = (array) ->
    if array.length ==0 then
      null
    else if array.length==1 then
      array[0]
    else
      _(array.sort (a,b)->
        newFirst(a.version,b.version)
      ).head!

  firstByVersionForAll =(array) ->
    _.chain(array).groupBy \id
    .pairs! .map ->
      firstByVersion it[1]
    .value!


  {firstByVersion,firstByVersionForAll }