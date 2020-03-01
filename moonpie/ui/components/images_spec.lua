-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Images", function()
  local components = require "moonpie.ui.components"
  local mock_love = require "moonpie.test_helpers.mock_love"

  it("loads the image from file/store", function()
    local img = components.image({ src = "assets/images/cat.jpg" })
    assert.equals(mock_love.image, img.image)
    assert.not_nil(img.image)
  end)

  it("uses the images layout", function()
    local layouts = require("moonpie.ui.layouts")
    local img = components.image({ src = "assets/images/cat.jpg" })
    assert.equals(layouts.image, img.layout)
    assert.not_nil(img.layout)
  end)

  it("tracks the source of the image", function()
    local img = components.image({ src = "assets/image/cat.jpg" })
    assert.equals("assets/image/cat.jpg", img.src)
  end)
end)
