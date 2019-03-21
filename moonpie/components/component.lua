-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local copy_keys = require "moonpie.copy_keys"
local copy_props = {
  "background_color",
  "color",
  "height",
  "id",
  "padding",
  "style",
  "width"
}

local component_factory = {}

local function find_by_id(component, id)
  for _, v in ipairs(component) do
    if v.id == id then
      return v
    end
    local out = find_by_id(v, id)
    if out then return out end
  end
end

local function create_component(name, render)
  component_factory[name] = function(props)
    props = props or {}
    local c = render(props)
    c.name = name

    c.update = function(self, new)
      copy_keys(new, self, true)
      self:flag_updates(true)
    end

    c.find_by_id = find_by_id

    c.flag_updates = function(_, f) c.updates_available = f end
    c.has_updates = function(_) return c.updates_available end

    for _, v in ipairs(copy_props) do
      if props[v] then c[v] = props[v] end
    end
    return c
  end

end

setmetatable(component_factory, { __call =
  function(_, name, render)
    return create_component(name, render)
  end
})

return component_factory
