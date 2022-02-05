-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local statistics = {}

function statistics.update(stat_name, value)
  local c = statistics[stat_name] or 0
  statistics[stat_name] = c + value
end

function statistics.increment(statName)
  statistics.update(statName, 1)
end

function statistics.decrement(statName)
  statistics.update(statName, -1)
end

return statistics