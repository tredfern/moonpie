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

local ComponentFactory = {}

local function find_by_id(component, id)
  for _, v in ipairs(component) do
    if v.id == id then
      return v
    end
    local out = find_by_id(v, id)
    if out then return out end
  end
end

function ComponentFactory.add_component_methods(c)
  if c.has_component_methods then return end

  c.update = function(self, new)
    copy_keys(new, self, true)
    self:flag_updates(true)
  end

  c.find_by_id = find_by_id

  c.flag_updates = function(self, f) self.updates_available = f end
  c.has_updates = function(self) return self.updates_available end

  c.show = function(self) self.hidden = false end
  c.hide = function(self) self.hidden = true end
  c.is_hidden = function(self) return self.hidden end

  c.add_style = function(self, style)
    self.style = string.format("%s %s", self.style or "", style)
  end

  c.remove_style = function(self, style)
    self.style = string.gsub(self.style, style, "")
  end

  c.has_component_methods = true
end

local function create_component(name, render)
  ComponentFactory[name] = function(props)
    props = props or {}
    local c = render(props)
    c.name = name

    ComponentFactory.add_component_methods(c)

    for _, v in ipairs(copy_props) do
      if props[v] then c[v] = props[v] end
    end
    return c
  end
end

setmetatable(ComponentFactory, { __call =
  function(_, name, render)
    return create_component(name, render)
  end
})

return ComponentFactory
