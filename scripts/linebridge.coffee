# Description:
#   test of line bridge
#
#
# Author:
#   mose

Line = require '../lib/linebridge'

module.exports = (robot) ->

  override = (object, methodName, callback) ->
    object[methodName] = callback(object[methodName])

  after = (extra) ->
    (original) ->
      ->
        returnValue = original.apply(this, arguments)
        extra.apply(this, arguments)
        returnValue

  passMessageFromRobot = (room, text) ->
    log = {
      room: room
      nick: robot.name
      message: text
    }
    faketime = moment.utc().add(1, 'second').format()
    Line.send log, room, robot, faketime
