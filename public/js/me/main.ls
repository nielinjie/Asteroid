define [\template!./me, \template!./repositoryStatus, \template!./myStatus,\template!./editMe, \repository,\jquery],
(temp,rtemp,mtemp,editT,repo,$)->
  update= ->
    $ \.me .empty!
    view!

  view= ->
    $(\.me) .append $(temp(repo.me!))
    $(\.repository-status) .append $(rtemp(repo.status!))
    $(\.my-status) .append $(mtemp!)
    $(\.me) .find \.edit-btn .popover do
      title: "edit"
      html: true
      content: ->
        editView(repo.me!)
      placement: "botton"

  editView= ->
    form=$ editT(it)
    form .find \.ok .click ->
      console.log 'ok'
#      repo.setMe do
      v= do
        name: {
          first: form.find \.first-name .val!
          last: form.find \.last-name .val!
        }
        picture: form.find \.picture .val!
        email: form.find \.email .val!
        memo: form.find \.memo .val!
      repo.setMe v
      update!
      require \items .update!
      require \friends .update!
      $ \.edit-btn .popover \hide
    form .find \.cancel .click ->
      console.log 'cancel'
      $ \.edit-btn .popover \hide
    form .find \.picture .change ->
      form .find \.preview .attr(\src , $ @ .val! )
    form

  {view,editView,update}
