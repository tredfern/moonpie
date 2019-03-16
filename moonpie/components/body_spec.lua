-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Body Component", function()
  local components = require "moonpie.components"

  it("will take any number of components passed in as props and render them out", function()
    local b = components.body({
      { text = "comp1" },
      { text = "comp2" },
      { text = "comp3" }
    })

    assert.equals(3, #b)
    assert.equals("comp1", b[1].text)
    assert.equals("comp2", b[2].text)
    assert.equals("comp3", b[3].text)
  end)
end)
