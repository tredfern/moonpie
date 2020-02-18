-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.ui.components.component")

Component("root", function()
  return {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight()
  }
end)

require("moonpie.ui.components.body")
require("moonpie.ui.components.section")
require("moonpie.ui.components.text")
require("moonpie.ui.components.headers")
require("moonpie.ui.components.images")
require("moonpie.ui.components.buttons")
require("moonpie.ui.components.checkbox")
require("moonpie.ui.components.list")
require("moonpie.ui.components.dropdown")
require("moonpie.ui.components.tree")
require("moonpie.ui.components.debug")
require("moonpie.ui.components.textbox")
require("moonpie.ui.components.hr")
require("moonpie.ui.components.icon")

return Component
