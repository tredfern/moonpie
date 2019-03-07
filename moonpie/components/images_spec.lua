-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Images", function()
  local components = require("moonpie.components")
  local image = require("moonpie.image")
  local mock_love = require("test_helpers.mock_love")

  it("loads the image from file/store", function()
    local old_load = image.load
    image.load = spy.new(function(...)  return old_load(...) end)
    local img = components.image({ src = "assets/images/cat.jpg" })
    assert.equals(mock_love.image, img.image)
    assert.not_nil(img.image)
  end)

  it("uses the images layout", function()
    local layouts = require("moonpie.layouts")
    local img = components.image({ src = "assets/images/cat.jpg" })
    assert.equals(layouts.image, img.layout)
    assert.not_nil(img.layout)
  end)

  it("uses the image renderer", function()
    local renderers = require("moonpie.renderers")
    local img = components.image({src = "image.jpg" })
    assert.equals(renderers.image, img.paint)
    assert.not_nil(img.paint)
  end)

end)
