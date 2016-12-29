moment = require 'moment'
path   = require 'path'

class LineBridge

  constructor: (@robot) ->
    @logger = @robot.logger
    @logger.debug 'Line Bridge Loaded'



module.exports = LineBridge
