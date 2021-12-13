-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Actions = {}
Actions.types = {
  ADD = "ENTITIES_ADD",
  REMOVE = "ENTITIES_REMOVE"
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

return Actions