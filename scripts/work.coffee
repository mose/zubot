# Description:
#   Just a work file
#
#
#
# Author:
#   mose

module.exports = (robot) ->

  # override = (object, methodName, callback) ->
  #   object[methodName] = callback(object[methodName])

  # after = (extra) ->
  #   (original) ->
  #     () ->
  #       returnValue = original.apply(this, arguments)
  #       extra.apply(this, arguments)
  #       returnValue

  # override(robot.adapter, 'send', after( (envelope, strings...) ->
  #   console.log strings...
  # ))


  robot.receiveMiddleware (context, next, done) ->
    message = context.response.message
    console.log message.constructor.name
    if message.constructor.name is "TextMessage"
      next(done)

  robot.receiveMiddleware (context, next, done) ->
    console.log '--------'
    done()


  robot.respond /showme/, (res) ->
    res.send [ "you #{res.message.user.name}", 'punk' ]

  robot.respond /whatip$/, (msg) ->
    if robot.auth?.isAdmin(msg.envelope.user)
      msg.http(process.env.IP_WATCHER)
        .get() (err, res, payload) -> 
          if res.statusCode == 200
            msg.send payload
          else
            console.log msg.statusCode
            console.log payload
            msg.send 'not found'

  robot.respond /setenv ([_A-Z]+) (.*)$/, (msg) ->
    if robot.auth?.isAdmin(msg.envelope.user)
      key = msg.match[1]
      value = msg.match[2]
      process.env[key] = value
      msg.send "Ok. #{key}=\"#{value}\""
    else
      msg.send "Unauthorized."

  robot.respond /room/, (res) ->
    res.send "This is #{res.envelope.room}"

  robot.respond /envelope/, (res) ->
    console.log res.envelope

  robot.respond /priv me/, (res) ->
    delete res.message.user.room
    res.send "woot"
