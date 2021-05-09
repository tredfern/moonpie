-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Images", function()
  local components = require "moonpie.ui.components"

  it("loads the image from file/store", function()
    local img = components.image({ source = "assets/images/cat.jpg" })
    assert.not_nil(img.image)
  end)

  it("uses the images layout", function()
    local layouts = require("moonpie.ui.layouts")
    local img = components.image({ source = "assets/images/cat.jpg" })
    assert.equals(layouts.image, img.layout)
    assert.not_nil(img.layout)
  end)

  it("tracks the source of the image", function()
    local img = components.image({ source = "assets/images/cat.jpg" })
    assert.equals("assets/images/cat.jpg", img.source)
  end)
end)
