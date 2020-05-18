-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(...)
  local out = {}
  for _, array in ipairs({...}) do
    for _, v in ipairs(array) do
      out[#out + 1] = v
    end
  end

  return out
end