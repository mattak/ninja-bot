# Description:
#   A way to interact with the Google Images API.
#
# Commands:
#   hubot image me <query> - The Original. Queries Google Images for <query> and returns a random top result.
#   hubot animate me <query> - The same thing as `image me`, except adds a few parameters to try to return an animated GIF instead.
#   hubot mustache me <url> - Adds a mustache to the specified URL.
#   hubot mustache me <query> - Searches Google Images for the specified query and mustaches it.

searchAndIncrements = (robot, msg, word) ->
  username = msg.message.user.name
  unless robot.brain.data['imagesearch']
    robot.brain.data['imagesearch'] = {}
  unless robot.brain.data['imagesearch'][username]
    robot.brain.data['imagesearch'][username] = {}
  unless robot.brain.data['imagesearch'][username][word]
    robot.brain.data['imagesearch'][username][word] = 0
  robot.brain.data['imagesearch'][username][word]++
  robot.brain.save()
  msg.send "東京都の#{ username.substr(0, 1).toUpperCase() }さん: #{ robot.brain.data['imagesearch'][username][word] }票"

module.exports = (robot) ->
  robot.respond /(image|img)( me)? (.*)/i, (msg) ->
    word = msg.match[3]
    imageMe msg, msg.match[3], (url) ->
      msg.send url
      searchAndIncrements robot, msg, word

  robot.respond /animate( me)? (.*)/i, (msg) ->
    word = msg.match[2]
    imageMe msg, msg.match[2], true, (url) ->
      msg.send url
      searchAndIncrements robot, msg, word

  robot.respond /(?:mo?u)?sta(?:s|c)he?(?: me)? (.*)/i, (msg) ->
    type = Math.floor(Math.random() * 6)
    mustachify = "http://mustachify.me/#{type}?src="
    imagery = msg.match[1]

    if imagery.match /^https?:\/\//i
      msg.send "#{mustachify}#{imagery}"
    else
      imageMe msg, imagery, false, true, (url) ->
        msg.send "#{mustachify}#{url}"

imageMe = (msg, query, animated, faces, cb) ->
  cb = animated if typeof animated == 'function'
  cb = faces if typeof faces == 'function'
  q = v: '1.0', rsz: '8', q: query, safe: 'active'
  q.imgtype = 'animated' if typeof animated is 'boolean' and animated is true
  q.imgtype = 'face' if typeof faces is 'boolean' and faces is true
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData?.results
      if images?.length > 0
        image  = msg.random images
        cb "#{image.unescapedUrl}#.png"

