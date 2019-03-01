-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.components.component")

Component("none", { })
Component("root", {
  background_color = "background",
  color = "text",
  width = love.graphics.getWidth(),
  height = love.graphics.getHeight()
})

Component("text", {
  display = "inline",
  color = "text"
})

require("moonpie.components.headers")
require("moonpie.components.buttons")
require("moonpie.components.vertical_scrollbar")
require("moonpie.components.debug")

return Component
