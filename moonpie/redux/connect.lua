-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local assign = require "moonpie.tables.assign"

return function(component, map_state_to_props)
  return function(props)
    local initial_state = map_state_to_props(store.getState())
    local p = assign({}, initial_state, props)
    local c = component(p)
    c.__listener = function()
      local v = map_state_to_props(store.getState(), c)
      c:update(v)
    end

    c.dispatch = store.dispatch

    store.subscribe(c.__listener)

    return c
  end
end