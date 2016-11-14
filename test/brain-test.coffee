Helper = require('hubot-test-helper')
chai = require 'chai'
# @link http://qiita.com/ykokw/items/2a52a7dfbe1c5eeb4aa8
co = require 'co'

expect = chai.expect

helper = new Helper('../src/brain.coffee')

describe 'brain', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'responds to yo', ->
    @room.user.say('alice', '@hubot yo').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot yo']
        ['hubot', 'yo']
      ]

  context 'brain', ->
    beforeEach ->
      #@room.robot.brain.data.kanban = ['task1']
      @room.user.say 'bob', '@hubot brain keep me in ur mind2'
      @room.user.say 'bob', '@hubot yo'
      @room.user.say 'bob', '@hubot get out'

    it 'How good is ur BRAIN?', ->
  #    @room.user.say('bob', '@hubot brain keep me in ur mind2').then =>
       expect(@room.messages).to.eql [
         ['bob', '@hubot brain keep me in ur mind2']
         ['bob', '@hubot yo']
         ['bob', '@hubot get out']
         ['hubot', 'yo']
         ['hubot', 'keep me in ur mind2']
         ['hubot', 'keep me in ur mind2']
       ]

