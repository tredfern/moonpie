-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.state.create_slice"
local Actions = require "moonpie.entities.actions"
local tables = require "moonpie.tables"

return createSlice({
  [Actions.types.ADD] = function(state, action)
    state[#state + 1] = action.payload.entity
    return state
  end,
  [Actions.types.ADD_SYSTEM] = function(state, action)
    if not state.systems then state.systems = {} end
    if not state.filters then state.filters = {} end
    table.insert(state.systems, action.payload.system)
    state.filters[action.payload.system] = action.payload.filters
    return state
  end,
  [Actions.types.REMOVE] = function(state, action)
    return tables.removeItem(state, action.payload.entity)
  end,
  [Actions.types.REMOVE_PROPERTY] = function(state, action)
    local e, p = action.payload.entity, action.payload.property
    e[p] = nil
    return state
  end,
  [Actions.types.REMOVE_SYSTEM] = function(state, action)
    tables.removeItem(state.systems, action.payload.system)
    state.filters[action.payload.system] = nil
    return state
  end,
  [Actions.types.UPDATE_PROPERTY] = function(state, action)
    local e, p, v = action.payload.entity, action.payload.property, action.payload.value
    if action.payload.copyValues and type(e[p]) == "table" then
      tables.copyKeys(v, e[p], true)
    else
      e[p] = v
    end
    return state
  end
})