// Generated by LiveScript 1.2.0
(function(){
  define(['moment', 'underscore'], function(moment, _){
    moment.lang('zh-cn');
    return {
      random: function(max){
        return Math.floor(Math.random() * max);
      },
      timeAgo: function(date){
        return moment(date).fromNow();
      },
      brief: function(text, length){
        if (text.length <= length) {
          return text;
        } else {
          return text.substr(0, length - 2) + '……';
        }
      },
      memorize: function(fun){
        var buffer, cache;
        buffer = {};
        cache = function(){
          var key;
          key = Array.prototype.join.call(_(arguments).map(function(it){
            return JSON.stringify(it);
          }, ''));
          if (!(key in buffer)) {
            buffer[key] = fun.apply(this, arguments);
          }
          return buffer[key];
        };
        cache.del = function(key){
          var ref$;
          if (!key) {
            return buffer = {};
          } else if (key in buffer) {
            return ref$ = buffer[key], delete buffer[key], ref$;
          }
        };
        cache.add = function(key, value){
          return buffer[key] = value;
        };
        return cache;
      },
      get: function(url){
        var _re;
        _re = [];
        $.ajax(url, {
          async: false,
          dataType: 'json'
        }).done(function(it){
          return _re = it;
        });
        return _re;
      },
      post: function(url, data){
        return $.ajax(url, {
          async: false,
          type: 'POST',
          data: data,
          dataType: 'json'
        });
      },
      put: function(url, data){
        return $.ajax(url, {
          async: false,
          type: 'PUT',
          data: data,
          dataType: 'json'
        });
      }
    };
  });
}).call(this);
