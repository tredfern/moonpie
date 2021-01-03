-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.redux.create_slice", function()
  local store = require "moonpie.redux.store"
  local create_slice = require "moonpie.redux.create_slice"

  it("takes a table and creates a function for the reducer", function()
    local test = {
      action_1 = function(state) return { v = (state.v or 0) + 1 } end,
      action_2 = function(state) return { v = (state.v or 0) + 2 } end
    }

    store.create_store(create_slice(test))

    store.dispatch({ type = "action_1" })
    local s = store.get_state()
    assert.equals(1, s.v)

    store.dispatch { type = "action_2" }
    s = store.get_state()
    assert.equals(3, s.v)
  end)
end)