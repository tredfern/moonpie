-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(slice_table)
  return setmetatable(slice_table, {
    __call = function(self, state, action)
      if self[action.type] then
        return self[action.type](state, action)
      end
    end
  })
end