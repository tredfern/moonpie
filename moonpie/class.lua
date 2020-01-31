-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = {}

function class:new(obj)
  local instance = obj or {}
  setmetatable(instance, { __index = self, __call = self.new })
  return instance
end

setmetatable(class, {
  __call = class.new
})

return class