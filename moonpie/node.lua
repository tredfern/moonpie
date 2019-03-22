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
  local cached_style = styles.compute(component, parent, {})

  local n = setmetatable({}, {
    __index = function(_, k)
      return cached_style[k]
    end
  })

  n.parent = parent
  n.component = component
  n.children = {}
  n.box = box_model(n, parent.box)

  n.add = function(self, ...)
    for _, v in ipairs({...}) do
      self.children[#self.children + 1] = v
    end
  end

  n.clear_children = function(self)
    self.children = {}
  end

  n.hover = function(self)
    local mx, my = love.mouse.getPosition()
    return self.box:region():contains(mx, my)
  end

  n.layout = function(...)
    local l = component.layout or layouts.standard
    l(...)
  end

  n.paint = component.paint or drawing.standard
  n.refresh_style = function(self)
    cached_style = styles.compute(component, parent, { hover = self.hover and self:hover() })
  end

  return n
end
