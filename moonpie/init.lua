-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...) .. "."

local renderer = require(BASE .. "renderer")
local gui

return {
  colors = require(BASE .. "colors"),
  component = require(BASE .. "component"),
  element = require(BASE .. "element"),
  paint = function()
    gui:paint()
  end,
  text = require(BASE .. "text"),
  update = function(...)
    gui = renderer(...)
  end,
}
