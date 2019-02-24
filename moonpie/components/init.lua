-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...) .. "."
local Component = require(BASE .. "component")

Component("none", { })
Component("root", { width = love.graphics.getWidth(), height = love.graphics.getHeight() })
require(BASE .. "vertical_scrollbar")

return Component
