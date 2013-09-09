define [\repository, \template!./friends, \template!./friend,  \jquery,\underscore] (repo,temp,ftemp,$,_)->
  view: ->
    $(\.friends) .append $(temp!)
    _(repo.friends!).each (u)->
      $(\.friends-list) .append $(ftemp(u))
