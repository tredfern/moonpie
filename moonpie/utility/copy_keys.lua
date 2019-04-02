-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(source, dest, overwrite)
  for k, v in pairs(source) do
    if overwrite or not dest[k] then
      dest[k] = v
    end
  end
end
