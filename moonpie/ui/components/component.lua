-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.utility.tables"
local copy_props = {
  "background_color",
  "border",
  "border_color",
  "click",
  "color",
  "component_mounted",
  "draw_component",
  "font_name",
  "font_size",
  "height",
  "hidden",
  "id",
  "keypressed",
  "keyreleased",
  "margin",
  "padding",
  "paint",
  "position",
  "style",
  "target_layer",
  "unmount",
  "width"
}

local ComponentFactory = {}
local Component_mt = { }

local search = {}
function search.find_by_id_imp(id, list)
  for _, v in ipairs(list) do
    if v.id == id then
      return v
    end
    local out = search.find_by_id(v, id)
    if out then return out end
  end
end

function search.find_by_id(component, id)
  local r = search.find_by_id_imp(id, component)
  if r then return r end
  if component.children then
    r = search.find_by_id_imp(id, component.children)
    if r then return r end
  end
end

function search.find_all_by_name(component, name, out)
  out = out or {}
  for _, v in ipairs(component) do
    if v.name == name then
      out[#out + 1] = v
    end
    search.find_all_by_name(v, name, out)
  end

  return out
end

function ComponentFactory.add_component_methods(c)
  setmetatable(c, Component_mt)
  if c.has_component_methods then return end

  c.update = function(self, new)
    tables.copy_keys(new, self, true)
    self:flag_updates(true)
  end

  c.find_by_id = search.find_by_id
  c.find_all_by_name = search.find_all_by_name

  c.flag_updates = function(self, f) self.updates_available = f end
  c.has_updates = function(self) return self.updates_available end
  c.flag_removal = function(self) self:update({ ready_to_remove = true }) end
  c.logger = require "moonpie.logger"
  c.needs_removal = function(self) return self.ready_to_remove end
  c.set_focus = function(self) require("moonpie.ui.user_focus"):set_focus(self) end

  c.show = function(self) self:update({ hidden = false}) end
  c.hide = function(self) self:update({ hidden = true}) end
  c.is_hidden = function(self) return self.hidden end

  c.add_style = function(self, style)
    self.style = string.format("%s %s", self.style or "", style)
  end

  c.remove_style = function(self, style)
    self.style = string.gsub(self.style, style, "")
  end

  c.get_node = function()
    return c.node
  end

  c.has_component_methods = true
end

local function create_component(name, render)
  ComponentFactory[name] = function(props)
    props = props or {}
    local c = render(props)
    if not c then error("Component did not render table") end
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
