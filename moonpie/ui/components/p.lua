-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local component = require "moonpie.ui.components.component"

component("p", function(props)
  local txt
  if type(props) == "string" then
    txt = props
  else
    txt = props.text
  end

  return {
    component.text({ text = txt })
  }
end)