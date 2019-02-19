-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...) .. "."

local layout_tree = require(BASE .. "layout_tree")
local gui

return {
  colors = require(BASE .. "colors"),
  component = require(BASE .. "component"),
  paint = function()
    gui:paint()
  end,
  text = require(BASE .. "text"),
  layout = function(...)
    gui = layout_tree(...)
  end,
}
