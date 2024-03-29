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
      payload = { entity = e, property = "position", value = { x = 84 }, copyValues = true }
    })

    assert.equals(84, e.position.x)
  end)

  it("can remove properties", function()
    local e = { foo = "bar" }
    local state = { e }
    reducer(state, {
      type = "ENTITIES_REMOVE_PROPERTY",
      payload = { entity = e, property = "foo" }
    })

    assert.is_nil(e.foo)
  end)

  it("can add systems", function()
    local s = function() end
    local f = {}

    local state = {}
    reducer(state, {
      type = "ENTITIES_ADD_SYSTEM",
      payload = { system = s, filters = f }
    })

    assert.array_includes(s, state.systems)
    assert.equals(f, state.filters[s])
  end)

  it("can remove systems", function()
    local s = function() end
    local state = { systems = { s }, filters = { [s] = {} } }
    reducer(state, {
      type = "ENTITIES_REMOVE_SYSTEM",
      payload = { system = s }
    })

    assert.not_array_includes(s, state.systems)
    assert.is_nil(state.filters[s])
  end)
end)