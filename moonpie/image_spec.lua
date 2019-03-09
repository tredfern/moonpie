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

  describe("Scale Calculator", function()
    it("returns the ratio needed to achieve the requested size", function()
      local i = mock_love.image
      local sx, sy = image.scale(i, 200, 250)
      assert.equals(2, sx)
      assert.equals(2.5, sy)
    end)

    it("returns decimal values to shrink the image", function()
      local i = mock_love.image
      local sx, sy = image.scale(i, 50, 75)
      assert.equals(0.5, sx)
      assert.equals(0.75, sy)
    end)

    it("can scale width", function()
      local i = mock_love.image
      local sx = image.scale_width(i, 50)
      assert.equals(0.50, sx)
    end)

    it("can scale height", function()
      local i = mock_love.image
      local sy = image.scale_height(i, 150)
      assert.equals(1.50, sy)
    end)
  end)
end)
