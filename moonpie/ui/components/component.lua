-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local template = require "moonpie.utility.template"
local updateQueue = require "moonpie.ui.update_queue"
local copy_props = {
  "backgroundColor",
  "border",
  "borderColor",
  "click",
  "clickSound",
  "color",
  "data",
  "drawComponent",
  "onUpdate",
  "fontName",
  "fontSize",
  "height",
  "hidden",
  "id",
  "keyPressed",
  "keyReleased",
  "margin",
  "mounted",
  "mouseDown",
  "onMouseMove",
  "mouseUp",
  "padding",
  "paint",
  "position",
  "style",
  "targetLayer",
  "textwrap",
  "unmounted",
  "width"
}

local ComponentFactory = {}
local Component_mt = { }

local search = {}
function search.findByID_imp(id, list)
  for _, v in ipairs(list) do
    if v.id == id then
      return v
    end
    local out = search.findByID(v, id)
    if out then return out end
  end
end

function search.findByID(component, id)
  local r = search.findByID_imp(id, component)
  if r then return r end
  if component.children then
    r = search.findByID_imp(id, component.children)
    if r then return r end
  end
end

function search.findAllByName(component, name, out)
  out = out or {}
  for _, v in ipairs(component) do
    if v.name == name then
      out[#out + 1] = v
    end
    search.findAllByName(v, name, out)
  end

  return out
end

function ComponentFactory.addComponentMethods(c)
  setmetatable(c, Component_mt)
  if c.hasComponentMethods then return end

  c.update = function(self, new)
    if tables.copyKeys(new, self, true) then
      self:flagUpdates(true)
      updateQueue:push(self)
      if self.onUpdate then
        self:onUpdate(new)
      end
    end
  end

  c.forceRefresh = function(self)
    self:flagUpdates(true)
    updateQueue:push(self)
  end

  c.findByID = search.findByID
  c.findAllByName = search.findAllByName

  c.flagUpdates = function(self, f) self.updates_available = f end
  c.hasUpdates = function(self) return self.updates_available end
  c.flagRemoval = function(self) self:update({ ready_to_remove = true }) end
  c.remove = function(self) self:flagRemoval() end
  c.logger = require "moonpie.logger"
  c.needsRemoval = function(self) return self.ready_to_remove end
  c.setFocus = function(self) require("moonpie.ui.user_focus"):setFocus(self) end
  c.blur = function() require("moonpie.ui.user_focus"):clear() end

  c.show = function(self) self:update({ hidden = false}) end
  c.hide = function(self) self:update({ hidden = true}) end
  c.isHidden = function(self) return self.hidden end

  c.addStyle = function(self, style)
    self.style = string.format("%s %s", self.style or "", style)
  end

  c.removeStyle = function(self, style)
    self.style = string.gsub(self.style, style, "")
  end

  c.getNode = function()
    return c.node
  end

  c.hasComponentMethods = true
end

local function createComponent(name, initializer)
  ComponentFactory[name] = function(props)
    props = props or {}
    local c = initializer(props)
    if not c then error("Component did not initialize.") end

    -- Build a new component using this render function
    if type(c) == "function" then
      local c2 = {
        render = c
      }
      tables.copyKeys(props, c2, false)
      c = c2
    end
    c.name = name

    ComponentFactory.addComponentMethods(c)

    for _, v in ipairs(copy_props) do
      if props[v] then
        if type(props[v]) == "string" then
          c[v] = template(props[v], props)
        else
          c[v] = props[v]
        end
      end
    end
    return c
  end

  return ComponentFactory[name]
end

setmetatable(ComponentFactory, { __call =
  function(_, name, initializer)
    return createComponent(name, initializer)
  end
})

return ComponentFactory
