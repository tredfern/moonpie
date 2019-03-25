-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.components.component"

Component("dropdown", function(props)
  local dd = {}
  dd.content = props.content or {}
  dd.content.id = "dropdown_content"
  dd.content.target_layer = "floating"
  dd.toggle = function() dd:update{ content_visible = not dd.content_visible } end

  dd.render = function()
    local o = dd.content_visible and dd.content or nil
    return Component.section({
      style = "dropdown",
      Component.button({ id = "dropdown_btn", caption = props.caption, click = dd.toggle }),
      o
    })
  end
  return dd
end)
