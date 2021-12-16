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

  it("can update property values", function()
    local e = { name = "Henry" }
    local state = { e }
    reducer(state, {
      type = "ENTITIES_UPDATE_PROPERTY",
      payload = { entity = e, property = "name", value = "boobear" }
    })

    assert.equals("boobear", e.name)
  end)

  it("can update complex property values", function()
    local e = { position = { x = 4, y = 3 }}
    local state = { e }
    reducer(state, {
      type = "ENTITIES_UPDATE_PROPERTY",
      payload = { entity = e, property = "position", value = { x = 84 } }
    })

    assert.equals(84, e.position.x)
  end)
end)