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
end)