// Generated by LiveScript 1.2.0
(function(){
  define(['items/item', 'version', 'underscore', 'util', 'jquery'], function(its, version, _, util, $){
    var pool, status, items, item, setMe, me, users, user, friends, friend, postItem, itemByUser, refresh, findItem;
    pool = function(init){
      var _pool, re;
      _pool = void 8;
      re = function(){
        if (_pool == null) {
          _pool = init();
        }
        return version.firstByVersionForAll(_pool);
      };
      re.del = function(){
        return _pool = void 8;
      };
      re.reload = function(){
        return _pool = init();
      };
      return re;
    };
    status = function(){
      return {
        items: items().length,
        meta: 307,
        keys: users().length
      };
    };
    items = pool(function(){
      return util.get('/items');
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
      util.put('/me', meUser);
      return me.del();
    };
    me = util.memorize(function(){
      return util.get('/me');
    });
    users = pool(function(){
      return util.get('/users');
    });
    user = function(id){
      return _(users()).find(function(it){
        return it.id === id;
      });
    };
    friends = function(){
      return users().filter(function(it){
        return it.id !== me().id;
      });
    };
    friend = function(id){
      return _(friends()).find(function(it){
        return it.id === id;
      });
    };
    postItem = function(item){
      items.del();
      return util.post('/items', item);
    };
    itemByUser = function(userId){
      return _(items()).filter(function(it){
        return it.author === userId;
      });
    };
    refresh = function(){
      users.del();
      items.del();
      return me.del();
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
      itemByUser: itemByUser,
      refresh: refresh
    };
  });
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
