-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.entities.actions", function()
  local Actions = require "moonpie.entities.actions"
  local Property = require "moonpie.entities.property"

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

  it("can specify to update a property", function()
    local entity = {}
    local action = Actions.updateProperty(entity, "name", "Foobar")
    assert.equals("ENTITIES_UPDATE_PROPERTY", action.type)
    assert.equals(entity, action.payload.entity)
    assert.equals("name", action.payload.property)
    assert.equals("Foobar", action.payload.value)
  end)

  it("can specify an update property should copy values", function()
    local entity = {}
    local action = Actions.updateProperty(entity, "name", "Foobar", true)
    assert.is_true(action.payload.copyValues)
  end)

  it("can take a property type to update and will replace the property value", function()
    local entity = {}
    local prop = Property("foo", "value")
    local action = Actions.updateProperty(entity, prop)

    assert.equals(entity, action.payload.entity)
    assert.equals("foo", action.payload.property)
    assert.equals("value", action.payload.value)
  end)

  it("can remove a property", function()
    local entity = { foo = "bar" }
    local action = Actions.removeProperty(entity, "foo")
    assert.equals("ENTITIES_REMOVE_PROPERTY", action.type)
    assert.equals(entity, action.payload.entity)
    assert.equals("foo", action.payload.property)
  end)
end)