-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.components.component"

Component("dropdown", function(props)
  local dd = {}
  dd.content = props.content or {}
  dd.content.position = "absolute"
  dd.content.id = "dropdown_content"
  dd.content.target_layer = "floating"
  dd.toggle = function() dd:update{ content_visible = not dd.content_visible } end

  dd.render = function(node)
    if dd.content_visible and dd.content then
      local r = node.box:region()
      dd.content.x = r.left
      dd.content.y = r.bottom
    end

    local floating_content = dd.content_visible and dd.content or nil
    return Component.section({
      style = "dropdown",
      Component.button({ id = "dropdown_btn", caption = props.caption, click = dd.toggle }),
      floating_content
    })
  end
  return dd
end)
