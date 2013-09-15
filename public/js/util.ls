define [\moment], (moment)->
  moment.lang \zh-cn
  random: (max)->
     Math.floor(Math.random! * max)
  timeAgo: (date) ->
    moment(date).fromNow!