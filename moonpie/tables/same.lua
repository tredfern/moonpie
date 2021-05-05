-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(t1, t2)
  if #t1 ~= #t2 then return false end

  for i, v in ipairs(t1) do
    if t2[i] ~= v then return false end
  end

  return true
end