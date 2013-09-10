define [\repository, \template!./items,\template!./item, \jquery,\underscore] , (repo,temp,itemp,$,_)->
  view: ->
    $(\.items) .append $(temp!)
    _(repo.items!).each ->
      $(\.items-list) .append $(itemp(it<<<{
        author:repo.friend(it.author)
      }))
