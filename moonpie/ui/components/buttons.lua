-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.ui.components.component")
local unpacker = require "moonpie.utility.unpack"

Component("button", function(props)
  local btn = {
    unpacker(props)
  }
  if props.caption then
    btn.caption = props.caption
    btn[#btn + 1] = Component.text({ id = "btn_text", text = props.caption, style = "align-center" })
  end
  return btn
end)

Component("button_group", function(props)
  local btngrp = { display = "inline" }

  for i, v in ipairs(props.buttons or {}) do
    btngrp[i] = v
  end

  return btngrp
end)

