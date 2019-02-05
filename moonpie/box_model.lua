-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

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
    content = { width = cw, height = ch },
    width = function(self) return self.content.width end,
    height = function(self) return self.content.height end
  }
  return box
end
