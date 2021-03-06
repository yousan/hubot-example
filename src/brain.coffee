# Description
#   A Hubot script to persist hubot's brain using text-file
#
# Configuration:
#   HUBOT_FILE_BRAIN_PATH
#
# Commands:
#   None
#
# Author:
#   bouzuya <m@bouzuya.net>
# @link http://qiita.com/bouzuya/items/ae1cb5610a64794bc522 Appreciate


Fs = require 'fs'

config =
  path: process.env.HUBOT_FILE_BRAIN_PATH

module.exports = (robot) ->
  robot.respond /(\S+)$/, (msg) ->
    message = msg.match[1]
    robot.brain.set 'example', message
    msg.send message

  robot.respond /brain (.*)$/, (msg) ->
    message = msg.match[1]
    console.log message
    robot.brain.set 'example', message
    msg.send message

  robot.respond /get out$/, (msg) ->
    message = msg.match[1]
    console.log 'deteke!'
    message = robot.brain.get 'example'
    msg.send message


  unless config.path?
    robot.logger.error 'process.env.HUBOT_FILE_BRAIN_PATH is not defined'
    return

  robot.brain.setAutoSave false

  load = ->
    if Fs.existsSync config.path
      data = JSON.parse Fs.readFileSync config.path, encoding: 'utf-8'
      robot.brain.mergeData data
    robot.brain.setAutoSave true

  save = (data) ->
    Fs.writeFileSync config.path, JSON.stringify data

  robot.brain.on 'save', save

  load()

