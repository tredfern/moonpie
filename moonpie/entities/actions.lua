-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Actions = {}
Actions.types = {
  ADD = "ENTITIES_ADD",
  ADD_SYSTEM = "ENTITIES_ADD_SYSTEM",
  REMOVE = "ENTITIES_REMOVE",
  REMOVE_PROPERTY = "ENTITIES_REMOVE_PROPERTY",
  REMOVE_SYSTEM = "ENTITIES_REMOVE_SYSTEM",
  UPDATE_PROPERTY = "ENTITIES_UPDATE_PROPERTY"
}

function Actions.add(entity)
  return {
    type = Actions.types.ADD,
    payload = {
      entity = entity
    }
  }
end

function Actions.addSystem(system, filters)
  return {
    type = Actions.types.ADD_SYSTEM,
    payload = {
      system = system,
      filters = filters
    }
  }
end

function Actions.remove(entity)
  return {
    type = Actions.types.REMOVE,
    payload = {
      entity = entity
    }
  }
end

function Actions.removeProperty(entity, property)
  return {
    type = Actions.types.REMOVE_PROPERTY,
    payload = {
      entity = entity,
      property = property
    }
  }
end

function Actions.removeSystem(system)
  return {
    type = Actions.types.REMOVE_SYSTEM,
    payload = {
      system = system
    }
  }
end

function Actions.updateProperty(entity, property, value, copyValues)
  if type(property) == "table" and property.name and property.value then
    value = property.value
    property = property.name
  end

  return {
    type = Actions.types.UPDATE_PROPERTY,
    payload = {
      entity = entity,
      property = property,
      value = value,
      copyValues = copyValues
    }
  }
end

return Actions