-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Selectors = {}

local function compareComponents(...)
  local components = tables.pack(...)

  return function(entity)
    return tables.all(components, function(c) return entity[c] end)
  end
end

function Selectors.getAllWithComponents(state, ...)
  local entities = state.entities
  local comparison = compareComponents(...)

  return tables.select(entities, comparison)
end

function Selectors.getFirstWithComponents(state, ...)
  local entities = state.entities
  local comparison = compareComponents(...)

  return tables.findFirst(entities, comparison)
end


return Selectors