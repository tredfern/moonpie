-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local WeightedTable = {}

function WeightedTable.new(entries)
  local wt =  {
    add = function(self, item, weight)
      table.insert(self, { item = item, weight = weight })
      self.totalWeight = tables.sum(self, function(i) return i.weight end)
    end,
    choose = function(self)
      local index = love.math.random(1, self.totalWeight)
      for _, v in ipairs(self) do
        index = index - v.weight
        if index <= 0 then
          return v.item
        end
      end
    end
  }

  if entries then
    for _, v in ipairs(entries) do
      wt:add(v[1], v[2])
    end
  end

  return wt
end


return WeightedTable