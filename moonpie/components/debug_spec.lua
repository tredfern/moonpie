-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Debug components", function()
  local mock_love = require "moonpie.test_helpers.mock_love"
  local components = require "moonpie.components"

  it("has an FPS counter that updates it's text every x seconds", function()
    local t = 32.32
    mock_love.mock(love.timer, "getFPS", function() return t end)
    local fps = components.fps_counter()
    assert.equals("FPS: 32.32", fps.text)
  end)
end)
