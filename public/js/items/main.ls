define [\repository, \template!./items,\template!./item, \jquery,\underscore,\uuid,\util] , (repo,temp,itemp,$,_,uuid,util)->

  addItem= (text)->
    item=do
      text: text
      id: new uuid().toString!
      author: repo.me!.id
      date:new Date()
      version:1
    repo.postItem item
    item

  addComment = (refId,text) ->
    item=do
      text: text
      id: new uuid().toString!
      author: repo.me!.id
      date:new Date()
      version:1
      ref:refId
      type:\comment
    repo.postItem item
    item
  addUp=(refId) ->
    item=do
      text: \:up
      id: new uuid().toString!
      author: repo.me!.id
      date:new Date()
      version:1
      ref:refId
      type:\up
    repo.postItem item
  addDown=(refId) ->
    item=do
      text: \:down
      id: new uuid().toString!
      author: repo.me!.id
      date:new Date()
      version:1
      ref:refId
      type:\down
    repo.postItem item
  countDown= (refId) ->
    repo.findItem ->
      it.type==\down and it.ref==refId
    .length
  countUp= (refId) ->
    repo.findItem ->
      it.type==\up and it.ref==refId
    .length
  countComment= (refId) ->
    repo.findItem ->
      it.type==\comment and it.ref==refId
    .length

  iDownIt=(refId)->
    repo.findItem ->
      it.type==\down and it.ref==refId and it.author==repo.me().id
    .length >0
  iUpIt=(refId)->
    repo.findItem ->
      it.type==\up and it.ref==refId and it.author==repo.me().id
    .length >0
  iCommentIt=(refId)->
    repo.findItem ->
      it.type==\comment and it.ref==refId and it.author==repo.me().id
    .length >0

  view: ->
    displayItem= ->
      $(itemp(it<<<{
        authorObj:repo.friend(it.author)
        timeAgo:util.timeAgo(it.date)
        downNum:countDown(it.id)
        upNum:countUp(it.id)
        commentNum:countComment(it.id)
        iDownIt: iDownIt(it.id)
        iUpIt: iUpIt(it.id)
        iCommentIt:iCommentIt(it.id)
        isComment:it.type==\comment
      }))

    $(\.items) .append $(temp!)
    _(repo.items!).chain!.sortBy ->
      - new Date(it.date)
    .each ->
      if it.type == \up or it.type == \down then
      else
        $(\.items-list) .append displayItem(it)

    $ \.text-send .val ''
    $(\.btn-send) .click -> addItem $(\.text-send).val!
    $(\.text-send) .keydown ->
      if it.which == 13
        it.preventDefault!
        item=addItem $(\.text-send).val!
        $(\.items-list) .prepend dispayItem(item)

    $(\.text-comment) .keydown ->
      if it.which == 13
        it.preventDefault!
        tf=$ @
        text= tf.val!
        refId=tf.closest \.list-group-item .data(\id)
        item=addComment(refId,text)
        $(\.items-list) .prepend dispayItem(item)

    $ \.up-button .click ->
      refId=$ @ .closest \.list-group-item .data(\id)
      item=addUp(refId)
    $ \.down-button .click ->
      refId=$ @ .closest \.list-group-item .data(\id)
      item=addDown(refId)

    $ \.comment-button .click ->
      $ @ .closest \.list-group-item .find \.comment-text .toggleClass \hide
    $ \.list-group-item .on 'mouseenter mouseleave' (e)->
      ($(e .target) .closest \.list-group-item )[if e.type == \mouseenter then \addClass else \removeClass] \hover
      e.preventDefault!

