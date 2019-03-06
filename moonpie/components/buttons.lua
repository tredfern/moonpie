-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.components.component")

Component("button", function(props)
  return {
    caption = props.caption,
    click = props.click,
    Component.text({ text = props.caption })
  }
end)

Component("button_group", function(props)
  local btngrp = { display = "inline" }

  for i, v in ipairs(props.buttons or {}) do
    btngrp[i] = v
  end

  return btngrp
end)

