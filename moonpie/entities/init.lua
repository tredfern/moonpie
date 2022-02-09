-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Entity = require "moonpie.entities.entity"
local store = require "moonpie.state.store"
local Events = require "moonpie.events"
local tables = require "moonpie.tables"

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

function Entities.addSystem(system, filter)
  store.dispatch(Entities.actions.addSystem(system, filter))
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

function Entities.removeSystem(system)
  store.dispatch(Entities.actions.removeSystem(system))
end

function Entities.changed(e)
  store.dispatch(Entities.actions.updateProperty(e, "changed", true))
end


function Entities.processUpdate()
  local systems = Entities.selectors.getSystems(store.getState())

  for _, s in ipairs(systems) do
    local state = store.getState()
    local filters = Entities.selectors.getFilter(state, s)
    local entities = Entities.selectors.findAll(store.getState(), tables.unpack(filters))
    s(entities)
  end
end


function Entities.enable()
  Events.beforeUpdate:add(Entities.processUpdate)
end

function Entities.disable()
  Events.beforeUpdate:remove(Entities.processUpdate)
end

Entities.enable()

return Entities