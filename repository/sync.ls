require! \./restler.js
require! \./db.js
require! async
_ = require \underscore
count=0

exports.sync = (station) ->
  #TODO support other station type
  url=station.url
  re=restler.get("#url/users/idv" , {parser:restler.parsers.json})
  console.log "re here"
  re.on(\success ,  (data,res)->
    remoteIdvs=data
    console.log count++
    console.log "remoteIds - #remoteIdvs"
    db.users.find {} (err,data)->
      thisIdvs=_(data).map ->
        [it.id, it.version.name]
      console.log "thisIds - #thisIdvs"
      console.log "this-remote - #{diff(thisIdvs,remoteIdvs)}"
      console.log "remote-this - #{diff(remoteIdvs,thisIdvs)}"
      postUsersTo(station, diff(thisIdvs,remoteIdvs))
      getUsers(station, diff(remoteIdvs,thisIdvs))
  )
  void
postUsersTo = (station,idvs) ->
  url=station.url
  async.each idvs, (idv,cb)->
    users=db.users.findOne {id:idv[0],'version.name':idv[1]}, (err,data)->
      restler.post "#url/users",  {data:data} .on \complete ->
        cb()

getUsers = (station, idvs) ->
  url=station.url
  async.each idvs, (idv,cb)->
    restler.get "#url/users" ,{data:{id:idv[0],'version.name':idv[1]}}.on \success (data)->
      db.users.insert data, (err, data) ->
        cb()

diff = (a,b) -> #diff for a array which item is [id,v]
  a1=_(a).map ->
    it.join \,
  b1=_(b).map ->
    it.join \,
  _(a1).difference(b1).map ->
    it.split \,
