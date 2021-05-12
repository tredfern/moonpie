-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Body Component", function()
  local components = require "moonpie.ui.components"

  it("takes contents and renders them out", function()
    local b = components.body {
      content = {
        { id = "comp1" },
        { id = "comp2" },
        { id = "comp3" }
      }
    }

    assert.not_nil(b:findByID("comp1"))
    assert.not_nil(b:findByID("comp2"))
    assert.not_nil(b:findByID("comp3"))
  end)
end)
