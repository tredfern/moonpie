-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Layers", function()
  local layers = require "moonpie.layers"

  it("has a UI layer", function()
    assert.not_nil(layers.ui)
  end)

  it("has a modal layer", function()
    assert.not_nil(layers.modal)
  end)

  it("has a debug layer", function()
    assert.not_nil(layers.debug)
  end)

  it("returns the layers in an order for proper rendering", function()
    local order = layers.render_order()
    assert.equals(layers.ui, order[1])
    assert.equals(layers.modal, order[2])
    assert.equals(layers.debug, order[3])
  end)
end)
