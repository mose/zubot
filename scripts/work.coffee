# Description:
#   Just a work file
#
#
#
# Author:
#   mose

module.exports = (robot) ->

  robot.respond /showme/, (res) ->
    res.send "you #{res.message.user.name}"

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
