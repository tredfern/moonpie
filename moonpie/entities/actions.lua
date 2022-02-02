-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Actions = {}
Actions.types = {
  ADD = "ENTITIES_ADD",
  REMOVE = "ENTITIES_REMOVE",
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

function Actions.updateProperty(entity, property, value, copyValues)
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