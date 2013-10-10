define [\repository, \template!./friends, \template!./friend,  \jquery,\underscore] (repo,temp,ftemp,$,_)->
  update=->
    $ \.friends .empty!
    view!
  view= ->
    $(\.friends) .append $(temp!)
    _(repo.friends!).each (u)->
      u=u<<<
        itemCount:repo.itemByUser(u.id).length
      $(\.friends-list) .append $(ftemp(u))

  {update,view}