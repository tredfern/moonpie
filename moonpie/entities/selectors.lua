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

function Selectors.findAll(state, ...)
  local filters = tables.pack(...)
  local propertyNames = tables.selectType(filters, "string")
  local customFilters = tables.selectType(filters, "function")

  return tables.select(state.entities, function(entity)
    return tables.all(propertyNames, function(c) return entity[c] end) and
      tables.all(customFilters, function(filter) return filter(entity) end)
  end)
end

function Selectors.findFirst(state, ...)
  local filters = tables.pack(...)
  local propertyNames = tables.selectType(filters, "string")
  local customFilters = tables.selectType(filters, "function")

  return tables.findFirst(state.entities, function(entity)
    return tables.all(propertyNames, function(c) return entity[c] end) and
      tables.all(customFilters, function(filter) return filter(entity) end)
  end)
end


return Selectors