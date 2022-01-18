-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local safecall = require "moonpie.utility.safe_call"
local class = {}

function class:subclass(prototype)
  setmetatable(prototype, self)
  self.__index = self
  return prototype
end

function class:new(...)
  local instance = {}
  setmetatable(instance, self)
  self.__index = self
  safecall(instance.constructor, instance, ...)
  return instance
end

setmetatable(class, {
  __call = class.subclass
})

return class