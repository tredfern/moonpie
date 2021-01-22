-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.find_by_component", function()
  local find_by_component = require "moonpie.ui.find_by_component"
  local node = require "moonpie.ui.node"

  it("finds a node in the tree that contains this component", function()
    local find_me = {}
    local n1 = node({})
    local c1 = node({})
    local c2 = node(find_me)
    n1:add(c1, c2)

    assert.equals(c2, find_by_component(n1, find_me))
  end)

end)