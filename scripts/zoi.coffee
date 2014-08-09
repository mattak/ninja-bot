# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot zoi - Show some zoi

CSON = require('cson');
config = CSON.parseFileSync 'config/irc.cson', (err, obj) -> {}
KIMONO_URL = config["api"]["zoi"]
request = require("request")

respondZoi = (msg) ->
  request KIMONO_URL, (err, response, body) ->
    zoi = JSON.parse(body)
    msg.send "#{ zoi['results']['randoms'][0]['img'] }"

module.exports = (robot) ->
  robot.respond /zoi$/i, (msg) ->
    respondZoi(msg)
  robot.hear /ぞい$/i, (msg) ->
    respondZoi(msg)
