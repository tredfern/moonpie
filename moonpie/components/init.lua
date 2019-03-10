-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.components.component")

Component("root", function()
  return {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight()
  }
end)

require("moonpie.components.section")
require("moonpie.components.text")
require("moonpie.components.headers")
require("moonpie.components.images")
require("moonpie.components.buttons")
require("moonpie.components.debug")

return Component
