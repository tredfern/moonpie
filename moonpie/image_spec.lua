-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Image", function()
  local image = require "moonpie.image"
  local mock_love = require "moonpie.test_helpers.mock_love"

  it("returns the same image if the same name is requested", function()
    local i = image.load("assets/images/cat.jpg")
    local j = image.load("assets/images/cat.jpg")

    assert.equals(i, j)
  end)

  it("fetches the image from love if not available", function()
    mock_love.mock(love.graphics, "newImage", spy.new(function() return mock_love.image end))
    image.load("assets/images/foo.jpg")
    assert.spy(love.graphics.newImage).was.called.with("assets/images/foo.jpg")
  end)
end)
