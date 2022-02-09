-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(iter)
  local out = {}
  local next = iter()

  while next do
    table.insert(out, next)
    next = iter()
  end

  return out
end