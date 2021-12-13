-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Entity = {}

function Entity.new(...)
  local e = {}

  for _, v in ipairs{...} do
    e[v.name] = v.value
  end

  return e
end

return Entity