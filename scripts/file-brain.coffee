# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   FILE_BRAIN_PATH
#
# Commands:
#   None
#
# Author:
#   dustyburwell

fs   = require 'fs'
path = require 'path'

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
