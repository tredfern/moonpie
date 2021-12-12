-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(reducers)
  return function(state, action)
    state = state or {}
    local s = {}
    for k, v in pairs(reducers) do
      s[k] = v(state[k], action)
    end
    return s
  end
end