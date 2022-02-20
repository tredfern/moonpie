-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(value, matchTable)
  if matchTable[value] then
    if type(matchTable[value]) == "function" then
      return matchTable[value]()
    end

    return matchTable[value]
  end

  -- Return default
  return matchTable._
end