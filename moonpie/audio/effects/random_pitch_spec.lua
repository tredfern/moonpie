-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.audio.effects.random_pitch", function()
  local randomPitch = require "moonpie.audio.effects.random_pitch"
  local sourceHandler = require "moonpie.audio.source_handler"
  local mockLove = require "moonpie.test_helpers.mock_love"

  it("takes a range to pitch shift and then applies that each play through", function()
    local source = sourceHandler(mockLove.newAudioClip())
    local pitch = randomPitch(source, 0.9, 1.3)

    pitch:play()

  end)
end)