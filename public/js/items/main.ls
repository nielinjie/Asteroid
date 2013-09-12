define [\repository, \template!./items,\template!./item, \jquery,\underscore,\uuid] , (repo,temp,itemp,$,_,uuid)->
  view: ->
    $(\.items) .append $(temp!)
    _(repo.items!).chain!.sortBy ->
      - new Date(it.date)
    .each ->
      $(\.items-list) .append $(itemp(it<<<{
        author:repo.friend(it.author)
      }))
    addItem= ->
      item=do
        text: $(\.text-send).val!
        id: new uuid().toString!
        author: repo.me!.id
        date:new Date()
        version:1
      repo.postItem item
      $(\.items-list) .prepend $(itemp(item<<<{
        author:repo.friend(item.author)
      }))
    addComment = (refId,text) ->
      item=do
        text: text
        id: new uuid().toString!
        author: repo.me!.id
        date:new Date()
        version:1
        ref:refId
      repo.postItem item


    $ \.text-send .val ''
    $(\.btn-send) .click -> addItem!
    $(\.text-send) .keydown ->
      if it.which == 13
        it.preventDefault!
        addItem!
    $(\.text-comment) .keydown ->
      if it.which == 13
        it.preventDefault!
        tf=$ @
        text= tf.val!
        refId=tf.closest \.list-group-item .data(\id)
        addComment(refId,text)

    $ \.comment-button .click ->
      $ @ .closest \.list-group-item .find \.comment-text .toggleClass \hide


