-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT



return function(type, handler)
  return setmetatable({
    type = type,
    handler = handler
  }, {
    __call = function(self, dispatch, getState)
      return self.handler(dispatch, getState)
    end
  })
end