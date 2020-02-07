-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local collections = require "moonpie.collections"
local world = {}

function world:new()
  local w = {}
  w.systems = collections.list:new()
  w.queued_entities = collections.list:new()
  w.queued_removal_entities = collections.list:new()
  w.entities = collections.indexed_set:new()
  w.filter_groups = {}
  setmetatable(w, { __index = self })
  return w
end

function world:add_systems(...)
  for _, v in ipairs({...}) do
    self:add_filter_group(v.filter)
    self.systems:add(v)
  end
end

function world:add_entities(...)
  self.queued_entities:add(...)
end

function world:remove_entities(...)
  self.queued_removal_entities:add(...)
end

function world:process(event)
  self:update_filter_groups()

  local has_event = function(e) return e[event] ~= nil end
  for s in collections.iterators.filtered(self.systems, has_event) do
    if s.filter then
      s[event](s, self.filter_groups[s.filter], love.timer.getDelta())
    else
      s[event](s, love.timer.getDelta())
    end
  end
end

function world:add_filter_group(filter)
  if not filter then return end

  self.filter_groups[filter] = collections.indexed_set:new()
  for e in collections.iterators.filtered(self.entities, filter) do
    self.filter_groups[filter]:add(e)
  end
end

function world:update_filter_groups()
  for _, e in ipairs(self.queued_entities) do
    for filter, filter_entities in pairs(self.filter_groups) do
      if filter(e) then
        filter_entities:add(e)
        self:trigger_system_entity_added(filter, e)
      end
    end
    self.entities:add(e)
  end

  for _, e in ipairs(self.queued_removal_entities) do
    for filter, filter_entities in pairs(self.filter_groups) do
      if (filter_entities:contains(e)) then
        filter_entities:remove(e)
        self:trigger_system_entity_removed(filter, e)
      end
    end
    self.entities:remove(e)
  end
  self.queued_entities:clear()
end

function world:trigger_system_entity_added(filter, entity)
  local s = self.systems:find(function(l) return l.filter == filter end)
  if s and s.entity_added then
    s:entity_added(entity)
  end
end

function world:trigger_system_entity_removed(filter, entity)
  local s = self.systems:find(function(l) return l.filter == filter end)
  if s and s.entity_removed then
    s:entity_removed(entity)
  end
end

return world