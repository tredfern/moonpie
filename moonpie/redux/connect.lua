-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"

return function(component, map_state_to_props)
  return function(props)
    local c = component(props)
    c.__listener = function()
      local v = map_state_to_props(store.get_state())
      c:update(v)
    end

    c.dispatch = store.dispatch

    store.subscribe(c.__listener)

    return c
  end
end