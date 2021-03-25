-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.audio.source_handler", function()
  local sourceHandler = require "moonpie.audio.source_handler"
  local mockLove = require "moonpie.test_helpers.mock_love"

  it("can handle multiple instances of a sound playing", function()
    local audio = sourceHandler:new(mockLove.newAudioClip())
    audio:play()
    audio:play()
    assert.equals(2, #audio.instances)
  end)

  it("reuses a slot if the clip is stopped", function()
    local audio = sourceHandler:new(mockLove.newAudioClip())
    local a1 = audio:play()
    a1:stop()
    local a2 = audio:play()

    assert.equals(a1, a2)
    assert.equals(1, #audio.instances)
  end)

  it("allows you to configure the sound settings before playing with a configuration routine", function()
    local audio = sourceHandler:new(mockLove.newAudioClip())
    local config = spy.new(function(a) a:setVolume(28) end)

    audio:play(config)
    assert.spy(config).was.called()
  end)
end)