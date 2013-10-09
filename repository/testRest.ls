restler=require \restler

re=restler.get ('http://localhost:4731/users/id')
console.log "re create here"
re.on \success,  (data,res)->
  console.log 're on success'

restler1=require \restler


re1=restler1.get ('http://localhost:4731/users')
console.log "re1 create here"
re1.on \success,  (data,res)->
  console.log 're1 on success'