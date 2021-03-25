-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.audio", function()
  local audio = require "moonpie.audio"
  local MockLove = require "moonpie.test_helpers.mock_love"

  it("can load static sound files", function()
    local audioFile = {}
    MockLove.mock(love.audio, "newSource", spy.new(function() return audioFile end))

    local sound = audio.getStatic("assets/sound/file")
    assert.equals(audioFile, sound.source)
    assert.spy(love.audio.newSource).was.called_with("assets/sound/file", "static")
  end)

  it("can load streaming sound files", function()
    local audioFile = {}
    MockLove.mock(love.audio, "newSource", spy.new(function() return audioFile end))

    local sound = audio.getStreaming("assets/sound/file")
    assert.equals(audioFile, sound.source)
    assert.spy(love.audio.newSource).was.called_with("assets/sound/file", "stream")
  end)

  it("reuses the same audio source if already loaded", function()
    local audioFile = {}
    MockLove.mock(love.audio, "newSource", spy.new(function() return audioFile end))

    local sound = audio.getStreaming("assets/sound/file/loadonce")
    assert.equals(sound, audio.getStreaming("assets/sound/file/loadonce"))
    assert.equals(sound, audio.getStreaming("assets/sound/file/loadonce"))
    assert.equals(sound, audio.getStreaming("assets/sound/file/loadonce"))
    assert.equals(sound, audio.getStreaming("assets/sound/file/loadonce"))

    assert.spy(love.audio.newSource).was.called(1)
  end)

  it("provides access to the rest of the love audio library", function()
    assert.not_nil(love.audio.play)
    assert.equals(love.audio.play, audio.play)
  end)
end)
