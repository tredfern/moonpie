-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Selectors = {}

function Selectors.getAllWithComponents(state, ...)
  local entities = state.entities

  local components = tables.pack(...)

  local comparison = function(entity)
    return tables.all(components, function(c) return entity[c] end)
  end

  return tables.select(entities, comparison)
end


return Selectors