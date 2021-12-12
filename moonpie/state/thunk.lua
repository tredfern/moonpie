-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT



return function(type, handler, validate)
  return setmetatable({
    type = type,
    handler = handler,
    validate = validate
  }, {
    __call = function(self, dispatch, getState)
      if not self.validate or self.validate(getState) then
        return self.handler(dispatch, getState)
      end
    end
  })
end