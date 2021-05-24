-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local isCallable = require "moonpie.utility.is_callable"

return function(tbl, functionName, override)
  assert(isCallable(tbl[functionName]))

  local swapper = setmetatable({
    originalTable = tbl,
    functionName = functionName,
    originalFunction = tbl[functionName],
    newFunction = override,
    revert = function(self)
      self.originalTable[functionName] = self.originalFunction
    end
  }, {
    __call = function(self, ...)
      return self.newFunction(...)
    end
  })

  tbl[functionName] = swapper
end