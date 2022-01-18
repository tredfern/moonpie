-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.entities.selectors", function()
  local selectors = require "moonpie.entities.selectors"

  it("can return entities that contain a specific property", function()
    local state = {
      entities = {
        { name = "foo", position = {}, image = {} },
        { name = "bar", position = {}, image = {} },
        { name = "ignore", position = {}, something = {} },
        { name = "ok", position = {}, image = {} },
      }
    }

    local results = selectors.getAllWithComponents(state, "position", "image")
    assert.equals(3, #results)
  end)

  it("can return the first entity with matching components", function()
    local state = {
      entities = {
        { name = "foo", position = {}, specialProp = true }
      }
    }

    local f = selectors.getFirstWithComponents(state, "specialProp")
    assert.equals(state.entities[1], f)
  end)
end)