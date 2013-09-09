define [\uuid] (uuid)->
  item: (id, text, author, date, version)->
    {id,text,authro,date,version}
  newItem: (text, author)->
    {id:new uuid().toString!,text,author,date:new Date(),version:0}