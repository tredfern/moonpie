-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BoxModel = require("moonpie.ui.box_model")
local layouts = require("moonpie.ui.layouts")
local drawing = require("moonpie.ui.drawing")
local styles = require("moonpie.ui.styles")
local List = require ("moonpie.collections.list")
local safecall = require "moonpie.utility.safe_call"
local statistics = require "moonpie.statistics"
local mouse = require "moonpie.mouse"

return function(component, parent)
  component = component or {}
  parent = parent or {}
  local cachedStyle = styles.compute(component, parent, {})

  local n = setmetatable({}, {
    __index = function(_, k)
      return cachedStyle[k]
    end
  })

  n.parent = parent
  n.component = component
  n.children = List:new()
  n.box = BoxModel(n, parent.box)

  n.add = function(self, ...)
    for _, v in ipairs({...}) do
      v.parent = self
      v.box:setParent(self.box)
      self.children[#self.children + 1] = v
    end
  end

  n.clear_children = function(self)
    for _, v in ipairs(self.children) do
      safecall(v.destroy, v)
    end
    self.children:clear()
  end

  n.hover = function(self)
    local mx, my = love.mouse.getPosition()
    return self.box:region():contains(mx, my)
  end

  n.layout = function(...)
    if n.beforeLayout then n:beforeLayout() end
    local l = component.layout or layouts.standard
    l(...)
    if n.afterLayout then n:afterLayout() end
  end

  n.paint = function(self)
    self:refreshStyle()
    local p = component.paint or drawing.standard
    p(n)
  end
  n.refreshStyle = function(self)
    cachedStyle.updateFlags({ hover = self.hover and self:hover() })
  end

  n.destroy = function(self)
    n.component.node = nil
    n.parent = nil
    safecall(n.component.unmounted, n.component)
    n.component = nil
    for _, v in ipairs(self.children) do
      v:destroy()
    end
    statistics.update("nodes", -1)
  end

  n.handle_click = function()
    local mx, my = mouse.getPosition()
    if n.box:region():contains(mx, my) then
      n:click()
    end
  end

  statistics.update("nodes", 1)
  --Assign reference back for component
  n.component.node = n
  return n
end
