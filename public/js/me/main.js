// Generated by LiveScript 1.2.0
(function(){
  define(['template!./me', 'template!./repositoryStatus', 'template!./myStatus', 'template!./editMe', 'repository', 'jquery'], function(temp, rtemp, mtemp, editT, repo, $){
    var update, view, editView;
    update = function(){
      $('.me').empty();
      return view();
    };
    view = function(){
      $('.me').append($(temp(repo.me())));
      $('.repository-status').append($(rtemp(repo.status())));
      $('.my-status').append($(mtemp()));
      return $('.me').find('.edit-btn').popover({
        title: "edit",
        html: true,
        content: function(){
          return editView(repo.me());
        },
        placement: "botton"
      });
    };
    editView = function(it){
      var form;
      form = $(editT(it));
      form.find('.ok').click(function(){
        var v;
        console.log('ok');
        v = {
          name: {
            first: form.find('.first-name').val(),
            last: form.find('.last-name').val()
          },
          picture: form.find('.picture').val(),
          email: form.find('.email').val(),
          memo: form.find('.memo').val()
        };
        repo.setMe(v);
        update();
        require('items').update();
        require('friends').update();
        return $('.edit-btn').popover('hide');
      });
      form.find('.cancel').click(function(){
        console.log('cancel');
        return $('.edit-btn').popover('hide');
      });
      form.find('.picture').change(function(){
        return form.find('.preview').attr('src', $(this).val());
      });
      return form;
    };
    return {
      view: view,
      editView: editView,
      update: update
    };
  });
}).call(this);
