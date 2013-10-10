// Generated by LiveScript 1.2.0
(function(){
  var uuid, _;
  uuid = require('uuid');
  _ = require('underscore');
  exports.plus = function(versions){
    return {
      name: uuid.v4(),
      base: versions
        ? [].concat(versions)
        : []
    };
  };
  exports.newer = function(a, b){
    var ref$, ref1$;
    if (((ref$ = (ref1$ = a.base) != null ? ref1$.length : void 8) != null ? ref$ : 0) > 0) {
      return _(a.base).any(function(it){
        return it.name === b.name || exports.newer(it, b);
      });
    } else {
      return false;
    }
  };
  exports.newFirst = function(a, b){
    if (a.name === b.name) {
      return 0;
    } else if (exports.newer(a, b)) {
      return -1;
    } else {
      return 1;
    }
  };
  exports.firstByVersion = function(array){
    if (array.length === 0) {
      return null;
    } else if (array.length === 1) {
      return array[0];
    } else {
      return _(array.sort(function(a, b){
        return exports.newFirst(a.version, b.version);
      })).head();
    }
  };
}).call(this);
