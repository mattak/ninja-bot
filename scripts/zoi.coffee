# Description:
#   Utility commands surrounding Hubot uptime.
#
# Configuration:
#   HUBOT_ZOI_API_URL - A kimonolabs url that returns json. The format is such as {'results':{'randoms':[{'img':'https://host/something.jpg:large'}]}}
#
# Commands:
#   hubot zoi - Show some zoi
#
# Author:
#   mattak

request = require('request')

unless process.env.HUBOT_ZOI_API_URL?
  robot.logger.warning 'The HUBOT_ZOI_API_URL environment variable not set'

respondZoi = (msg) ->
  unless process.env.HUBOT_ZOI_API_URL?
    msg.send "please set HUBOT_ZOI_API_URL"
  else
    request process.env.HUBOT_ZOI_API_URL, (err, response, body) ->
      zoi = JSON.parse(body)
      img = zoi['results']['randoms'][0]['img']
      if img
        img = img.replace(/:large$/, "")
      msg.send "#{ img }"

module.exports = (robot) ->
  robot.respond /zoi$/i, (msg) ->
    respondZoi(msg)
  robot.hear /ぞい$/i, (msg) ->
    respondZoi(msg)
