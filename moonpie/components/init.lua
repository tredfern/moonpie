-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...) .. "."
local Component = require(BASE .. "component")

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

require(BASE .. "headers")
require(BASE .. "buttons")
require(BASE .. "vertical_scrollbar")

return Component
