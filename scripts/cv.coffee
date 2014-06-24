# Description:
#   Search character voice actors.
#
# Commands:
#   hubot cv <actor_name> - Displays all program and character name that match actor name <actor_name>.
#
# URLS:
#   /cv
#
# Notes:
#   Now Developing

request = require('request')
MAX_PRINT_LINE = 10

module.exports = (robot) ->
  getEncodeQuery = (str) ->
    return encodeURIComponent str

  searchActor = (query, callback) ->
    option = {
      url: "http://character-voice.me/search/actor/#{ query }.json",
      json: true
    }

    request.get option, (error, response, body) ->
      if not error and response.statusCode == 200
        lines = []

        if body.length > 0
          actor = body[0]
          characters = actor["characters"]
          programs   = actor["programs"]

          for idx of characters
            line = "#{ characters[idx]['name'] } / #{ programs[idx]['title'] }"
            lines.push line

        callback(null, lines)
      else
        callback({status: response.statusCode, error: error}, null)

  # search
  robot.hear /^!?cv (.+)/i, (msg) ->
    query = getEncodeQuery(msg.match[1])
    searchActor query, (err, list) ->
      for idx of list
        msg.send list[idx]
        if idx >= MAX_PRINT_LINE
          msg.send "... #{ list.length } actors"
