_ = require(\underscore)
require! \../util.js
require! \fs

data=fs.readFileSync("#{__dirname}/dummy.txt", encoding:'utf8')

exports.texts= do
  _.chain(data.split('\n')).map ->
    it.trim!
  .filter ->
    it!=''
  .map ->
    it.slice(1,util.random(140))
  .shuffle!
  .value!



