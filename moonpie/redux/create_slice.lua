-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local safeCall = require "moonpie.utility.safe_call"

return function(slice_table)
  return setmetatable(slice_table, {
    __call = function(self, state, action)
      state = state or safeCall(slice_table.initialState) or {}
      if self[action.type] then
        return self[action.type](state, action)
      end

      return state
    end
  })
end