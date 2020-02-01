-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(t, ...)
  for _, v in ipairs({...}) do
    if not t[v] then
      return false
    end
  end
  return true
end