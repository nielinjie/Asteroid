// Generated by LiveScript 1.2.0
(function(){
  define(['items/item', 'version', 'underscore', 'util', 'jquery'], function(its, version, _, util, $){
    var refresh, get, post, put, status, items, item, setMe, me, users, user, friends, friend, postItem, itemByUser, findItem;
    refresh = function(){};
    get = function(url){
      var _re;
      _re = [];
      $.ajax(url, {
        async: false,
        dataType: 'json'
      }).done(function(it){
        return _re = it;
      });
      return _re;
    };
    post = function(url, data){
      return $.ajax(url, {
        async: false,
        type: 'POST',
        data: data,
        dataType: 'json'
      });
    };
    put = function(url, data){
      return $.ajax(url, {
        async: false,
        type: 'PUT',
        data: data,
        dataType: 'json'
      });
    };
    status = function(){
      return {
        items: items().length,
        meta: 307,
        keys: users().length
      };
    };
    items = util.memorize(function(){
      return version.firstByVersionForAll(get('/items'));
    });
    item = function(id){
      return _(items()).find(function(it){
        return it.id === id;
      });
    };
    setMe = function(user){
      var meUser;
      users.del();
      meUser = me();
      import$(meUser.name, user.name);
      import$(meUser, _(user).omit('name'));
      put('/me', meUser);
      return me.del();
    };
    me = util.memorize(function(){
      return get('/me');
    });
    users = util.memorize(function(){
      return version.firstByVersionForAll(get('/users'));
    });
    user = function(id){
      return _(users()).find(function(it){
        return it.id === id;
      });
    };
    friends = function(){
      return users().filter(function(it){
        return !deepEq$(it.id, me().id, '===');
      });
    };
    friend = function(id){
      return _(friends()).find(function(it){
        return it.id === id;
      });
    };
    postItem = function(item){
      items.del();
      return post('/items', item);
    };
    itemByUser = function(userId){
      return _(items()).filter(function(it){
        return it.author === userId;
      });
    };
    findItem = function(where){
      return _(items()).where(where);
    };
    return {
      status: status,
      items: items,
      item: item,
      me: me,
      setMe: setMe,
      friends: friends,
      friend: friend,
      postItem: postItem,
      findItem: findItem,
      users: users,
      user: user,
      itemByUser: itemByUser
    };
  });
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
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
