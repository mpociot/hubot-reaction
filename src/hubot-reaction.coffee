# Description:
#   Reagion gifs
#
# Dependencies:
#   None
#
# Configuration:
#   None
# 
# Commands:
#   !reply tag - returns reaction gif from replygif.net, with that tag
# 
format = require('util').format
module.exports = (robot) ->
  robot.parseReplyGifTag = (text) ->
    text.toLowerCase().replace(/[^\w \-]+/g, '').replace(/--+/g, '').replace(/\ /g, '-')
  robot.hear /^!reply (.+)$/, (msg) ->
    msg.http('http://replygif.net/api/gifs?tag='+tag+'&api-key=39YAprx5Yi')
      .header('Accept', 'application/json')
      .get() (err, response, body) ->
        results = JSON.parse(body)
        if results.length == 0
          errorMsg = "no gifs for '#{tag}' -- probably invalid category/tag"
          robot.send {user: {name: msg.message.user}}, errorMsg
        else
          ind = Math.floor(Math.random() * results.length)
          msg.send results[ind].file
