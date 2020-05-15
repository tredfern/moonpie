-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(source, dest, overwrite)
  local modified = false
  if source == nil then return modified end

  for k, v in pairs(source) do
    if overwrite or not dest[k] then
      if dest[k] ~= v then
        modified = true
        dest[k] = v
      end
    end
  end

  return modified
end
