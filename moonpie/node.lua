-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local box_model = require("moonpie.box_model")
local layouts = require("moonpie.layouts")
local renderers = require("moonpie.renderers")

return function(component, parent)
  return setmetatable({
    component = component or {},
    box = box_model(component, parent),
    children = {},
    parent = parent,

    add = function(self, ...)
      for _, v in ipairs({...}) do
        self.children[#self.children + 1] = v
      end
    end,

    hover = function(self)
      local mx, my = love.mouse.getPosition()
      return self.box:region():contains(mx, my)
    end,

    layout_children = layouts.children,
    layout = layouts.standard,

    refresh_needed = function(self)
      return self.component.refresh_layout
    end,

    paint = renderers.standard
  }, {
    __index = component
  })
end
