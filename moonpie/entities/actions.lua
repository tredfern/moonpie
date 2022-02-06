-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Actions = {}
Actions.types = {
  ADD = "ENTITIES_ADD",
  REMOVE = "ENTITIES_REMOVE",
  REMOVE_PROPERTY = "ENTITIES_REMOVE_PROPERTY",
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