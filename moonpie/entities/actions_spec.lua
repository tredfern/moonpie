-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.entities.actions", function()
  local Actions = require "moonpie.entities.actions"

  it("can create an add entity action", function()
    local entity = {}
    local action = Actions.add(entity)

    assert.equals("ENTITIES_ADD", action.type)
    assert.equals(entity, action.payload.entity)
  end)

  it("can create a remove entity action", function()
    local entity = {}
    local action = Actions.remove(entity)

    assert.equals("ENTITIES_REMOVE", action.type)
    assert.equals(entity, action.payload.entity)
  end)
end)