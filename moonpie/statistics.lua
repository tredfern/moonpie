-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local statistics = {}

function statistics.update(stat_name, value)
  local c = statistics[stat_name] or 0
  statistics[stat_name] = c + value
end

return statistics