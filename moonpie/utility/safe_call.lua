-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local isCallable = require "moonpie.utility.is_callable"

return function(f, ...)
  if isCallable(f) then
    return f(...)
  end
end