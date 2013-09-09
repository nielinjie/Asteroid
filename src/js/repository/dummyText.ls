define [\text!./dummy.txt,\underscore,\util] (te,_,util)->
  _.chain(te.split('\n')).map ->
    it.trim!
  .filter ->
    it!=''
  .map ->
    it.slice(1,util.random(140))
  .shuffle!
  .value!
