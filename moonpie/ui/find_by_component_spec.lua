-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.find_by_component", function()
  local findByComponent = require "moonpie.ui.find_by_component"
  local Node = require "moonpie.ui.node"

  it("finds a node in the tree that contains this component", function()
    local find_me = {}
    local n1 = Node({})
    local c1 = Node({})
    local c2 = Node(find_me)
    n1:add(c1, c2)

    assert.equals(c2, findByComponent(n1, find_me))
  end)

end)