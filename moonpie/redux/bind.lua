-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"

return function(component, binder)
  component.__binder = function()
    binder(component, store.getState())
  end

  store.subscribe(component.__binder)
  return component
end