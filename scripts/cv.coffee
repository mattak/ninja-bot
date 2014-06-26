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
_       = require('underscore')

MAX_PRINT_LINE = 10

module.exports = (robot) ->
  getEncodeQuery = (str) ->
    return encodeURIComponent str

  # search: actor
  searchActor = (query, callback) ->
    option = {
      url: "http://character-voice.me/search/actor/#{ query }.json",
      json: true
    }

    request.get option, (error, response, body) ->
      if not error and response.statusCode == 200
        lines = []
        name  = null

        if body.length > 0
          actor = body[0]
          name  = actor['name']
          characters = actor["characters"]
          programs   = actor["programs"]

          for idx of characters
            line = "#{ characters[idx]['name'] } / #{ programs[idx]['title'] }"
            lines.push line

        callback(null, name, lines)
      else
        callback({status: response.statusCode, error: error}, null, null)

  # serach: program
  searchProgram = (query, callback) ->
    option = {
      url: "http://character-voice.me/search/program/#{ query }.json",
      json: true
    }

    request.get option, (error, response, body) ->
      if not error and response.statusCode == 200
        lines = []
        title = null

        if body.length > 0
          program = body[0]
          title = program['title']
          characters = program['characters']

          for idx of characters
            character = characters[idx]
            actor =  character['actor']
            lines.push "#{ character['name'] } / #{ actor['name'] }"

        callback(null, title, lines)
      else
        callback({status: response.statusCode, error: error}, title, null)

  doSearch = (func, msg, query) ->
    func query, (err, match, list) ->
      if match
        msg.send "-> #{ match }"
      for idx of list
        msg.send list[idx]
        if idx >= MAX_PRINT_LINE
          msg.send "... #{ list.length } results"
          break

  # search
  robot.hear /^!?cv actor (.+)/i, (msg) ->
    query = getEncodeQuery(msg.match[1])
    doSearch searchActork, msg, query

  # search
  robot.hear /^!?cv program (.+)/i, (msg) ->
    query = getEncodeQuery(msg.match[1])
    doSearch searchProgram, msg, query
