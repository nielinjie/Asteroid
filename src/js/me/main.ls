define [\template!./me, \template!./repositoryStatus, \template!./myStatus, \repository,\jquery] (temp,rtemp,mtemp,repository,$)->
  view: ->
    $(\.me) .append $(temp(repository.me!))
    $(\.repository-status) .append $(rtemp(repository.status!))
    $(\.my-status) .append $(mtemp!)
  update: ->

