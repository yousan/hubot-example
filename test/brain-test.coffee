Helper = require('hubot-test-helper')
chai = require 'chai'
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

  it 'How good is ur BRAIN?', ->
    @room.user.say('bob', '@hubot brain keep me in ur mind2').then =>
      expect(@room.messages).to.eql [
        ['bob', '@hubot brain keep me in ur mind2']
        ['hubot', 'keep me in ur mind2']
        ['bob', '@hubot yo']
        ['hubot', 'yo']
        ['bob', '@hubot get out']
        ['hubot', 'keep me in ur mind']
      ]

