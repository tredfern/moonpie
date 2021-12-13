-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.entities.entity", function()
  local Entity = require "moonpie.entities.entity"
  local Property = require "moonpie.entities.property"

  it("can return a new entity", function()
    local e = Entity.new()
    assert.is_table(e)
  end)

  it("can take some properties to define the entity", function()
    local e = Entity.new(
      Property("name", "Oskar"),
      Property("position", { x = 10, y = 39 })
    )

    assert.equals("Oskar", e.name)
    assert.equals(10, e.position.x)
    assert.equals(39, e.position.y)
  end)
end)