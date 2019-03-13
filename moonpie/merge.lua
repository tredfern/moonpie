-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(main, secondary)
  main = main or {}
  secondary = secondary or {}
  local out = {}

  for k, v in pairs(secondary) do
    out[k] = v
  end

  for k, v in pairs(main) do
    out[k] = v
  end

  return out
end
