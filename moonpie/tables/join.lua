-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(...)
  local joined = {}

  for _, v in ipairs({...}) do
    for _, item in ipairs(v) do
      joined[#joined + 1] = item
    end
  end

  return joined
end