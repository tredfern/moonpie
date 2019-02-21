-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...) .. "."

local layout_tree = require(BASE .. "layout_tree")
local gui
local mouse = require(BASE .. "mouse")

local moonpie = {
  colors = require(BASE .. "colors"),
  component = require(BASE .. "component"),
  mouse = mouse,
  paint = function()
    gui:paint()
  end,
  text = require(BASE .. "text"),
  layout = function(...)
    gui = layout_tree(...)
  end,
  update = function()
    mouse:update(gui)
  end
}

-- set up base components
require(BASE .. "components")

return moonpie
