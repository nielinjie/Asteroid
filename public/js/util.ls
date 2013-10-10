define [\moment,\underscore], (moment,_)->
  moment.lang \zh-cn
  random: (max)->
     Math.floor(Math.random! * max)

  timeAgo: (date) ->
    moment(date).fromNow!
  brief:(text,length)->
    if text.length<=length then
      text
    else
      text.substr(0,length-2)+\……
  memorize:(fun)->
    buffer = {};
    cache = ->
      key = Array.prototype.join.call(_(arguments).map ->
        JSON.stringify(it)
      , '')
      if (!(key of buffer)) then
        buffer[key] := fun.apply(this, arguments);
      buffer[key];
    cache.del = (key)->
      if (!key) then
        buffer := {};
      else if(key of buffer) then
        delete buffer[key];
    cache.add = (key, value)->
      buffer[key] := value;
    cache

  get:(url) ->
    _re=[]
    $ .ajax url ,
      {async:false,dataType:\json}
    .done ->
      _re:=it
    _re
  post:(url, data) ->
    $ .ajax url , do
      async:false
      type:\POST
      data: data
      dataType: \json

  put:(url, data) ->
    $ .ajax url , do
      async:false
      type:\PUT
      data: data
      dataType: \json