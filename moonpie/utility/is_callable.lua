-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(val)
  if type(val) == "function" then return true end
  if type(val) == "table" then
    local mt = getmetatable(val)
    if mt and type(mt.__call) == "function" then
      return true
    end
  end

  return false
end