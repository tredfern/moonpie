-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Component = require "moonpie.components.component"
local Logger = require "moonpie.logger"

Component("dropdown_content", function(props)
  return Component.section({
    id = "dropdown_content",
    position = "absolute",
    target_layer = "floating",
    props.content or {}
  })
end)

Component("dropdown", function(props)
  local dd = {}
  dd.content = Component.dropdown_content(props)
  dd.content:hide()
  dd.toggle = function()
    if dd.content:is_hidden() then
      local r = dd:get_node().box:region()
      dd.content:update({x = r.left, y = r.bottom})
      dd.content:show()
    else
      dd.content:hide()
    end
  end

  dd.render = function()
    return Component.section({
      style = "dropdown",
      Component.button({ id = "dropdown_btn", caption = props.caption, click = dd.toggle }),
      dd.content
    })
  end

  dd.unmounted = function()
    Logger.debug("Dropdown unmounted")
    dd.content:flag_removal()
  end
  return dd
end)

Component("dropdown_menu", function(props)
  local menu = {}
  for i, v in ipairs(props.options) do
    menu[i] = Component.dropdown_menu_option(v)
  end
  return Component.dropdown({
    caption = props.caption,
    content = Component.dropdown_menu_content(menu)
  })
end)

Component("dropdown_menu_content", function(props)
  return props
end)

Component("dropdown_menu_option", function(props)
  return {
    click = props.click,
    Component.text({ text = props.caption })
  }
end)