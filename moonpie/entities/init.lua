-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Entity = require "moonpie.entities.entity"
local store = require "moonpie.state.store"

local Entities = {
  actions = require "moonpie.entities.actions",
  entity = Entity,
  property = require "moonpie.entities.property",
  reducer = require "moonpie.entities.reducer",
  selectors = require "moonpie.entities.selectors",
  new = Entity.new
}

function Entities.add(e)
  store.dispatch(Entities.actions.add(e))
end

function Entities.update(e, property, value, copyValues)
  store.dispatch(Entities.actions.updateProperty(e, property, value, copyValues))
end

function Entities.remove(e)
  store.dispatch(Entities.actions.remove(e))
end

function Entities.removeProperty(e, property)
  store.dispatch(Entities.actions.removeProperty(e, property))
end

function Entities.changed(e)
  store.dispatch(Entities.actions.updateProperty(e, "changed", true))
end

return Entities