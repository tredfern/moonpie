-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.components.icon", function()
  require "moonpie.ui.components.icon"
  local image = require "moonpie.graphics.image"
  local components = require "moonpie.ui.components.component"

  it("is a component that can be created", function()
    local icon = components.icon({ icon = "card-jack-spades" })
    assert.not_nil(icon)
  end)

  it("uses the icon property to set find the source for the image component returned", function()
    mock(image)
    components.icon({ icon = "card-jack-spades" })
    assert.spy(image.load).was.called_with("./moonpie/assets/icons/aussiesim/card-jack-spades.png")
  end)

  it("creates some basic icon components for setting different sizes", function()
    assert.not_nil(components.icon_xsmall({ icon = "card-jack-spades" }))
    assert.not_nil(components.icon_small({ icon = "card-jack-spades" }))
    assert.not_nil(components.icon_medium({ icon = "card-jack-spades" }))
    assert.not_nil(components.icon_large({ icon = "card-jack-spades" }))
    assert.not_nil(components.icon_xlarge({ icon = "card-jack-spades" }))
  end)

  it("uses the image layout", function()
    local icon = components.icon({ icon = "card-jack-spades" })
    local layouts = require "moonpie.ui.layouts"
    assert.equals(layouts.image, icon.layout)
  end)
end)