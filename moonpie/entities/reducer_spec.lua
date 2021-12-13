-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.entities.reducer", function()
  local reducer = require "moonpie.entities.reducer"

  it("can process adding entities", function()
    local e = {}
    local state = reducer({}, {
      type = "ENTITIES_ADD",
      payload = { entity = e }
    })

    assert.array_includes(e, state)
  end)

  it("can process removing entities", function()
    local e = {}
    local state = { e }
    state = reducer(state, {
      type = "ENTITIES_REMOVE",
      payload = { entity = e }
    })

    assert.not_array_includes(e, state)
  end)
end)