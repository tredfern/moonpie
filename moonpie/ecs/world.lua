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

function world:process(event)
  self:update_filter_groups()

  local has_event = function(e) return e[event] ~= nil end
  for s in collections.iterators.filtered(self.systems, has_event) do
    if s.filter then
      s[event](s, self.filter_groups[s.filter])
    else
      s[event](s)
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
      end
    end
    self.entities:add(e)
  end
  self.queued_entities:clear()
end

return world