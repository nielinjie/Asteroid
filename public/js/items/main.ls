define [\repository, \template!./items,\template!./item,\template!./itemBrief, \scrollTo,\jquery,\underscore,\uuid,\util] , (repo,temp,itemp,briefT,scrollTo,$,_,uuid,util)->

  addItem= (text)->
    item=do
      text: text
      id: new uuid().toString!
      author: repo.me!.id
      date:new Date()
    repo.postItem item
    item

  addComment = (refId,text) ->
    item=do
      text: text
      id: new uuid().toString!
      author: repo.me!.id
      date:new Date()
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
      ref:refId
      type:\up
    repo.postItem item
    item
  addDown=(refId) ->
    item=do
      text: \:down
      id: new uuid().toString!
      author: repo.me!.id
      date:new Date()
      ref:refId
      type:\down
    repo.postItem item
    item
  countDown= (refId) ->
    repo.findItem do
      type: \down
      ref: refId
    .length
  countUp= (refId) ->
    repo.findItem do
      type: \up
      ref: refId
    .length
  countComment= (refId) ->
    repo.findItem do
      type: \comment
      ref: refId
    .length

  iDownIt=(refId)->
    repo.findItem do
      type: \down
      ref: refId
      author: repo.me().id
    .length >0
  iUpIt=(refId)->
    repo.findItem do
      type: \up
      ref: refId
      author: repo.me().id
    .length >0
  iCommentIt=(refId)->
    repo.findItem do
      type: \comment
      ref: refId
      author: repo.me().id
    .length >0


  update= ->
     $ \.items .empty!
     view!

  view= ->
    displayItem= ->
      item=it<<<{
        authorObj:repo.user(it.author)
        timeAgo:util.timeAgo(it.date)
        downNum:countDown(it.id)
        upNum:countUp(it.id)
        commentNum:countComment(it.id)
        iDownIt: iDownIt(it.id)
        iUpIt: iUpIt(it.id)
        iCommentIt:iCommentIt(it.id)
        isComment:it.type==\comment
        hasComments:false
      }
      if item.isComment then
        ref=repo.item(item.ref)
        item<<<{
          commentRef: {
            id:ref.id
            picture:repo.user(ref.author).picture
            text:ref.text
            textBrief:util.brief(ref.text,35)
          }
          briefTemplate:briefT
        }
      if item.commentNum > 0 then
        comments=repo.findItem do
          type: \comment
          ref: item.id
        item<<<{
          hasComments:true
          comments:_(comments) .map ->
            {
              id:it.id
              picture:repo.user(it.author).picture
              text:it.text
              textBrief:util.brief(it.text,35)
            }
          briefTemplate:briefT
        }
      $(itemp(item))
    updateItem=(refId) ->
      i=$ \.items-list .find ".list-group-item[data-id=#{refId}]"
      item=repo.item(refId)
      i.replaceWith(displayItem(item))

    $(\.items) .append $(temp!)
    _(repo.items!).chain!.sortBy ->
      - new Date(it.date)
    .each ->
      if it.type == \up or it.type == \down then
      else
        $(\.items-list) .append displayItem(it)

    $ \.text-send .val ''

    $(\.btn-send) .click ->
      item=addItem $(\.text-send).val!
      $ \.text-send .val ''
      $(\.items-list) .prepend displayItem(item)

    $(\.text-send) .keydown ->
      if it.which == 13
        it.preventDefault!
        item=addItem $(\.text-send).val!
        $ \.text-send .val ''
        $(\.items-list) .prepend displayItem(item)

    $(\.items-list).on \keydown , \.text-comment , (e)->
      if e.which == 13
        e.preventDefault!
        tf=$(e .target)
        text= tf.val!
        refId=tf.closest \.list-group-item .data(\id)
        item=addComment(refId,text)
        $(\.items-list) .prepend displayItem(item)
        updateItem(refId)
        tf.val ''

    $(\.items-list).on \click , \.up-button , (e)->
      refId=$(e .target) .closest \.list-group-item .data(\id)
      item=addUp(refId)
      updateItem(refId)
    $(\.items-list).on \click , \.down-button , (e)->
      refId=$(e .target) .closest \.list-group-item .data(\id)
      item=addDown(refId)
      updateItem(refId)

    $(\.items-list).on \dblclick , \.list-group-item , (e)->
      $(e.target) .closest \.list-group-item .toggleClass \expand

    $(\.items-list).on \click , \.expand-button , (e)->
      $(e.target) .closest \.list-group-item .toggleClass \expand


    $(\.items-list).on \click ,  \.comment-button , (e)->
      ct=$ @ .closest \.list-group-item .find \.comment-text
      ct .toggleClass \hide
      if not ct.hasClass \hide
        ct.find \.text-comment .focus!

    $(\.items-list).on \click , \.btn-goto , (e)->
      id= $(e.target) .closest \.item-brief .data \id
      fd=$ ".list-group-item[data-id=#id]"
      if fd.size!==1 then
        fd.addClass \expand
        $ \.items-list .scrollTo(".list-group-item[data-id=#id]")
      else
        #FIXME what if not find? maybe not displayed, maybe not known.

    $(\.items-list).on 'mouseenter mouseleave' \.list-group-item  (e)->
      ($(e .target) .closest \.list-group-item )[if e.type == \mouseenter then \addClass else \removeClass] \hover
      e.preventDefault!
    $(\.items-list).on 'mouseenter mouseleave' \.item-brief  (e)->
      ($(e .target) .closest \.item-brief )[if e.type == \mouseenter then \addClass else \removeClass] \hover
      e.preventDefault!

  {update,view}