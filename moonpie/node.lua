-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local box_model = require("moonpie.box_model")
local layouts = require("moonpie.layouts")
local drawing = require("moonpie.drawing")
local styles = require("moonpie.styles")

return function(component, parent)
  component = component or {}
  parent = parent or {}

  local n = setmetatable({}, {
    __index = function(self, k)
      local hover = rawget(self, "hover")
      return styles.compute(component, parent, { hover = hover and hover(self) })[k]
    end
  })

  n.children = {}
  n.parent = parent
  n.box = box_model(n, parent.box)

  n.add = function(self, ...)
    for _, v in ipairs({...}) do
      self.children[#self.children + 1] = v
    end
  end

  n.hover = function(self)
    local mx, my = love.mouse.getPosition()
    return self.box:region():contains(mx, my)
  end

  n.layout = function(...)
    local l = component.layout or layouts.standard
    l(...)
    component.refresh_layout = false
  end

  n.refresh_needed = function()
    return component.refresh_layout
  end

  n.paint = component.paint or drawing.standard

  return n
end
