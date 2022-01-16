-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.audio.effects.base", function()
  local base = require "moonpie.audio.effects.base"
  local sourceHandler = require "moonpie.audio.source_handler"
  local mockLove = require "moonpie.test_helpers.mock_love"

  it("provides a simple way to decorate audio sources", function()
    local audio = sourceHandler:new(mockLove.newAudioClip())
    local deco = spy.new(function() end)
    local shift = base(audio, deco)

    shift:play()
    assert.spy(deco).was.called()
  end)

  it("you should be able to chain effects", function()
    local audio = sourceHandler:new(mockLove.newAudioClip())
    local deco = spy.new(function() end)
    local shift = base(audio, deco)
    local deco2 = spy.new(function() end)
    local shift2 = base(shift, deco2)

    shift2:play()
    assert.spy(deco).was.called()
    assert.spy(deco2).was.called()
  end)
end)