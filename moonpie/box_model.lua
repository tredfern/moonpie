-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local rectangle = require(BASE .. "rectangle")

local function new_box(l, r, t, b)
  return {
    left = l,
    right = r,
    top = t,
    bottom = b
  }
end

return function(ctrl)
  local cw, ch = ctrl:content_size()
  local box = {}
  box.margin = new_box(0, 0, 0, 0)
  box.border = new_box(0, 0, 0, 0)
  box.padding = new_box(0, 0, 0, 0)
  box.content = rectangle{ width = cw, height = ch }
  box.area = rectangle{ width = cw, height = ch }
  return box
end
