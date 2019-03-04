-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.components.component")

Component("button", function(props)
  return {
    style = "button",
    click = props.click,
    Component.text({ text = props.caption })
  }
end)

Component("button_group", { display = "inline" })
