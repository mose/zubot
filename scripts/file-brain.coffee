fs   = require 'fs'
path = require 'path'
Util = require 'util'

module.exports = (robot) ->
  brainPath = process.env.FILE_BRAIN_FILE or '/var/hubot/brain-dump.json'

  try
    data = fs.readFileSync brainPath, 'utf-8'
    if data
      robot.brain.mergeData JSON.parse(data)
      robot.brain.emit 'loaded', ''
  catch error
      console.log('Unable to read file', error) unless error.code is 'ENOENT'

  robot.brain.on 'save', (data) ->
    fs.writeFileSync brainPath, JSON.stringify(data), 'utf-8'

  robot.respond /show storage$/i, (msg) ->
    if true or robot.auth.isAdmin(msg.message.user)
      output = Util.inspect(robot.brain.data, false, 4)
      msg.send output
    else
      msg.send "Sorry only admins can invoke this command."
