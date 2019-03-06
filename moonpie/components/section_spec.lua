-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Section", function()
  local components = require("moonpie.components")

  it("adds any children that are given to it", function()
    local c = components.section({ "child1", "child2", "child3" })
    assert.equals(3, #c)
    assert.equals("child1", c[1])
    assert.equals("child2", c[2])
    assert.equals("child3", c[3])
  end)
end)
