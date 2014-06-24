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

module.exports = (robot) ->
  robot.hear /^!?cv (.+)/i, (msg) ->
    msg.send "searching #{ msg.match[1] }"
