require! \uuid
_ = require \underscore
exports.plus = (versions) ->
  {
    name:uuid.v4!
    base: if versions then
      [].concat(versions)
    else
      []
  }

exports.newer = (a,b) ->
  if (a.base?.length ? 0) >0  then
    _(a.base).any ->
      it.name == b.name or exports.newer(it,b)
  else
    false

exports.newFirst = (a,b) ->
  if a.name==b.name then
    0
  else if exports.newer(a,b) then
    -1
  else
    1
exports.firstByVersion = (array) ->
  if array.length ==0 then
      null
  else if array.length==1 then
    array[0]
  else
    _(array.sort (a,b)->
      exports.newFirst(a.version,b.version)
    ).head!