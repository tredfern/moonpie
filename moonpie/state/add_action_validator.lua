-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(action, validator)
  if action.validate then
    local prev = action.validate
    action.validate = function(a, state)
      return prev(a, state) and validator(a, state)
    end
  else
    action.validate = validator
  end
end