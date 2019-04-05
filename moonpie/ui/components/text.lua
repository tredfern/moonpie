-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require("moonpie.ui.components.component")
local layouts = require "moonpie.ui.layouts"
local template = require "moonpie.utility.template"

Component("text", function(props)
  if type(props) == "string" then
    props = { text = props }
  end
  return {
    text = template(props.text, props),
    layout = layouts.text
  }
end)
