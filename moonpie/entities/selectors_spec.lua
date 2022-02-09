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

  it("provides a handy findAll method", function()
    local state = {
      entities = {
        { name = "foo", position = { x = 1, y = 3 }},
        { name = "bar", position = { x = 2, y = 3 }},
        { name = "jane", position = { x = 1, y = 3 }},
        { position = { x = 1, y = 3 }},
        { name = "lost-bob" },
      }
    }

    local list = selectors.findAll(state, "name", "position")
    assert.equals(3, #list)
    list = selectors.findAll(state, "name", "position", function(e) return e.name == "foo" end)
    assert.equals(1, #list)
  end)

  it("provides a handy findFirst method", function()
    local state = {
      entities = {
        { name = "foo", position = { x = 1, y = 3 }},
        { name = "bar", position = { x = 2, y = 3 }, player = true},
        { name = "jane", position = { x = 1, y = 3 }},
        { position = { x = 1, y = 3 }},
        { name = "lost-bob" },
      }
    }

    local e = selectors.findFirst(state, "name", "position", "player")
    assert.equals("bar", e.name)
    assert.is_true(e.player)
  end)

  it("can find all the systems", function()
    local state = {
      entities = {
        systems = { function() end, function() end }
      }
    }

    local result = selectors.getSystems(state)
    assert.equals(2, #result)
  end)

  it("can find the filter for a system", function()
    local s = function() end
    local f = {}

    local state = {
      entities = {
        systems = { s },
        filters = { [s] = f }
      }
    }

    local filter = selectors.getFilter(state, s)
    assert.equals(f, filter)
  end)
end)