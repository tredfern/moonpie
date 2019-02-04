-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function new_box(l, r, t, b)
  return {
    left = l,
    right = r,
    top = t,
    bottom = b
  }
end

local function get_size(ctrl)
  local cw, ch = 0, 0

  if ctrl.content_size then
    cw, ch = ctrl:content_size()
  end

  -- width/height properties override
  return ctrl.width or cw, ctrl.height or ch
end

return function(ctrl)
  ctrl = ctrl or { width = 0, height = 0 }
  local cw, ch = get_size(ctrl)

  local box = {
    x = 0, y = 0,
    margin = new_box(0, 0, 0, 0),
    border = new_box(0, 0, 0, 0),
    padding = new_box(0, 0, 0, 0),
    content = { width = cw, height = ch }
  }
  return box
end
