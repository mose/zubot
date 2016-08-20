# Description:
#   Just a work file
#
#
#
# Author:
#   mose

module.exports = (robot) ->

  robot.respond /showme/, (res) ->
    robot.logger.info res
    res.send "you #{res.message.user.name}"
