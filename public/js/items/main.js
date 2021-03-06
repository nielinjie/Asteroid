// Generated by LiveScript 1.2.0
(function(){
  define(['repository', 'template!./items', 'template!./item', 'template!./itemBrief', 'scrollTo', 'jquery', 'underscore', 'uuid', 'util'], function(repo, temp, itemp, briefT, scrollTo, $, _, uuid, util){
    var addItem, addComment, addUp, addDown, countDown, countUp, countComment, iDownIt, iUpIt, iCommentIt, update, view;
    addItem = function(text){
      var item;
      item = {
        text: text,
        id: new uuid().toString(),
        author: repo.me().id,
        date: new Date()
      };
      repo.postItem(item);
      return item;
    };
    addComment = function(refId, text){
      var item;
      item = {
        text: text,
        id: new uuid().toString(),
        author: repo.me().id,
        date: new Date(),
        ref: refId,
        type: 'comment'
      };
      repo.postItem(item);
      return item;
    };
    addUp = function(refId){
      var item;
      item = {
        text: ':up',
        id: new uuid().toString(),
        author: repo.me().id,
        date: new Date(),
        ref: refId,
        type: 'up'
      };
      repo.postItem(item);
      return item;
    };
    addDown = function(refId){
      var item;
      item = {
        text: ':down',
        id: new uuid().toString(),
        author: repo.me().id,
        date: new Date(),
        ref: refId,
        type: 'down'
      };
      repo.postItem(item);
      return item;
    };
    countDown = function(refId){
      return repo.findItem({
        type: 'down',
        ref: refId
      }).length;
    };
    countUp = function(refId){
      return repo.findItem({
        type: 'up',
        ref: refId
      }).length;
    };
    countComment = function(refId){
      return repo.findItem({
        type: 'comment',
        ref: refId
      }).length;
    };
    iDownIt = function(refId){
      return repo.findItem({
        type: 'down',
        ref: refId,
        author: repo.me().id
      }).length > 0;
    };
    iUpIt = function(refId){
      return repo.findItem({
        type: 'up',
        ref: refId,
        author: repo.me().id
      }).length > 0;
    };
    iCommentIt = function(refId){
      return repo.findItem({
        type: 'comment',
        ref: refId,
        author: repo.me().id
      }).length > 0;
    };
    update = function(){
      $('.items').empty();
      return view();
    };
    view = function(){
      var displayItem, updateItem;
      displayItem = function(it){
        var item, ref, comments;
        item = (it.authorObj = repo.user(it.author), it.timeAgo = util.timeAgo(it.date), it.downNum = countDown(it.id), it.upNum = countUp(it.id), it.commentNum = countComment(it.id), it.iDownIt = iDownIt(it.id), it.iUpIt = iUpIt(it.id), it.iCommentIt = iCommentIt(it.id), it.isComment = it.type === 'comment', it.hasComments = false, it);
        if (item.isComment) {
          ref = repo.item(item.ref);
          item.commentRef = {
            id: ref.id,
            picture: repo.user(ref.author).picture,
            text: ref.text,
            textBrief: util.brief(ref.text, 35)
          };
          item.briefTemplate = briefT;
        }
        if (item.commentNum > 0) {
          comments = repo.findItem({
            type: 'comment',
            ref: item.id
          });
          item.hasComments = true;
          item.comments = _(comments).map(function(it){
            return {
              id: it.id,
              picture: repo.user(it.author).picture,
              text: it.text,
              textBrief: util.brief(it.text, 35)
            };
          });
          item.briefTemplate = briefT;
        }
        return $(itemp(item));
      };
      updateItem = function(refId){
        var i, item;
        i = $('.items-list').find(".list-group-item[data-id=" + refId + "]");
        item = repo.item(refId);
        return i.replaceWith(displayItem(item));
      };
      $('.items').append($(temp()));
      _(repo.items()).chain().sortBy(function(it){
        return -new Date(it.date);
      }).each(function(it){
        if (it.type === 'up' || it.type === 'down') {} else {
          return $('.items-list').append(displayItem(it));
        }
      });
      $('.text-send').val('');
      $('.btn-send').click(function(){
        var item;
        item = addItem($('.text-send').val());
        $('.text-send').val('');
        return $('.items-list').prepend(displayItem(item));
      });
      $('.text-send').keydown(function(it){
        var item;
        if (it.which === 13) {
          it.preventDefault();
          item = addItem($('.text-send').val());
          $('.text-send').val('');
          return $('.items-list').prepend(displayItem(item));
        }
      });
      $('.items-list').on('keydown', '.text-comment', function(e){
        var tf, text, refId, item;
        if (e.which === 13) {
          e.preventDefault();
          tf = $(e.target);
          text = tf.val();
          refId = tf.closest('.list-group-item').data('id');
          item = addComment(refId, text);
          $('.items-list').prepend(displayItem(item));
          updateItem(refId);
          return tf.val('');
        }
      });
      $('.items-list').on('click', '.up-button', function(e){
        var refId, item;
        refId = $(e.target).closest('.list-group-item').data('id');
        item = addUp(refId);
        return updateItem(refId);
      });
      $('.items-list').on('click', '.down-button', function(e){
        var refId, item;
        refId = $(e.target).closest('.list-group-item').data('id');
        item = addDown(refId);
        return updateItem(refId);
      });
      $('.items-list').on('dblclick', '.list-group-item', function(e){
        return $(e.target).closest('.list-group-item').toggleClass('expand');
      });
      $('.items-list').on('click', '.expand-button', function(e){
        return $(e.target).closest('.list-group-item').toggleClass('expand');
      });
      $('.items-list').on('click', '.comment-button', function(e){
        var ct;
        ct = $(this).closest('.list-group-item').find('.comment-text');
        ct.toggleClass('hide');
        if (!ct.hasClass('hide')) {
          return ct.find('.text-comment').focus();
        }
      });
      $('.items-list').on('click', '.btn-goto', function(e){
        var id, fd;
        id = $(e.target).closest('.item-brief').data('id');
        fd = $(".list-group-item[data-id=" + id + "]");
        if (!deepEq$(fd.size, 1, '===')) {
          fd.addClass('expand');
          return $('.items-list').scrollTo(".list-group-item[data-id=" + id + "]");
        } else {}
      });
      $('.items-list').on('mouseenter mouseleave', '.list-group-item', function(e){
        $(e.target).closest('.list-group-item')[e.type === 'mouseenter' ? 'addClass' : 'removeClass']('hover');
        return e.preventDefault();
      });
      return $('.items-list').on('mouseenter mouseleave', '.item-brief', function(e){
        $(e.target).closest('.item-brief')[e.type === 'mouseenter' ? 'addClass' : 'removeClass']('hover');
        return e.preventDefault();
      });
    };
    return {
      update: update,
      view: view
    };
  });
  function deepEq$(x, y, type){
    var toString = {}.toString, hasOwnProperty = {}.hasOwnProperty,
        has = function (obj, key) { return hasOwnProperty.call(obj, key); };
    var first = true;
    return eq(x, y, []);
    function eq(a, b, stack) {
      var className, length, size, result, alength, blength, r, key, ref, sizeB;
      if (a == null || b == null) { return a === b; }
      if (a.__placeholder__ || b.__placeholder__) { return true; }
      if (a === b) { return a !== 0 || 1 / a == 1 / b; }
      className = toString.call(a);
      if (toString.call(b) != className) { return false; }
      switch (className) {
        case '[object String]': return a == String(b);
        case '[object Number]':
          return a != +a ? b != +b : (a == 0 ? 1 / a == 1 / b : a == +b);
        case '[object Date]':
        case '[object Boolean]':
          return +a == +b;
        case '[object RegExp]':
          return a.source == b.source &&
                 a.global == b.global &&
                 a.multiline == b.multiline &&
                 a.ignoreCase == b.ignoreCase;
      }
      if (typeof a != 'object' || typeof b != 'object') { return false; }
      length = stack.length;
      while (length--) { if (stack[length] == a) { return true; } }
      stack.push(a);
      size = 0;
      result = true;
      if (className == '[object Array]') {
        alength = a.length;
        blength = b.length;
        if (first) { 
          switch (type) {
          case '===': result = alength === blength; break;
          case '<==': result = alength <= blength; break;
          case '<<=': result = alength < blength; break;
          }
          size = alength;
          first = false;
        } else {
          result = alength === blength;
          size = alength;
        }
        if (result) {
          while (size--) {
            if (!(result = size in a == size in b && eq(a[size], b[size], stack))){ break; }
          }
        }
      } else {
        if ('constructor' in a != 'constructor' in b || a.constructor != b.constructor) {
          return false;
        }
        for (key in a) {
          if (has(a, key)) {
            size++;
            if (!(result = has(b, key) && eq(a[key], b[key], stack))) { break; }
          }
        }
        if (result) {
          sizeB = 0;
          for (key in b) {
            if (has(b, key)) { ++sizeB; }
          }
          if (first) {
            if (type === '<<=') {
              result = size < sizeB;
            } else if (type === '<==') {
              result = size <= sizeB
            } else {
              result = size === sizeB;
            }
          } else {
            first = false;
            result = size === sizeB;
          }
        }
      }
      stack.pop();
      return result;
    }
  }
}).call(this);
