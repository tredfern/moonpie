-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.redux.combine_reducers", function()
  local combine_reducers = require "moonpie.redux.combine_reducers"

  it("merges state results from multiple reducers into a single state based on keys", function()
    local r1 = function() return { v = "r1" } end
    local r2 = function() return { v = "r2" } end

    local cr = combine_reducers{ r1 = r1, r2 = r2 }
    local s = cr()
    assert.equals("r1", s.r1.v)
    assert.equals("r2", s.r2.v)
  end)

  it("passes the state of the property into the combined reducer function", function()
    local red = spy.new(function() return {} end)
    local cr = combine_reducers{ red = red }
    local state = { red = {} }
    cr(state)
    assert.spy(red).was.called_with(state.red, nil)
  end)
end)