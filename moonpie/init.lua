-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...) .. "."

local layout_tree = require(BASE .. "layout_tree")
local gui
local mouse = require(BASE .. "mouse")

local function check_node_for_refresh(n)
  if n.refresh_needed and n:refresh_needed() then
    return true
  end

  if n.children then
    for _, v in ipairs(n.children) do
      if check_node_for_refresh(v) then
        return true
      end
    end
  end

  return false
end

local moonpie = {
  colors = require(BASE .. "colors"),
  components = require(BASE .. "components"),
  font = require(BASE .. "font"),
  mouse = mouse,
  paint = function()
    gui:paint()
  end,
  text = require(BASE .. "text"),
  layout = function(...)
    gui = layout_tree(...)
    return gui
  end,
  update = function()
    mouse:update(gui)
    if gui and check_node_for_refresh(gui) then
      gui:layout()
    end
  end,
  themes = {
    standard = require(BASE .. "themes.standard"),
    light_mode = require(BASE .. "themes.light_mode"),
    dark_mode = require(BASE .. "themes.dark_mode")
  }
}

moonpie.themes.standard(moonpie)
moonpie.themes.light_mode(moonpie)

return moonpie
