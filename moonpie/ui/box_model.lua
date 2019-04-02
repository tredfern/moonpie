-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local region = require("moonpie.ui.region")

local function get_rekt(element, property)
  if type(element[property]) == "table" then
    return {
      left = element[property].left or 0,
      top = element[property].top or 0,
      right = element[property].right or 0,
      bottom = element[property].bottom or 0,
      landr = function(self) return self.left + self.right end,
      tandb = function(self) return self.top + self.bottom end
    }
  else
    local v = tonumber(element[property]) or 0
    return {
      left = v, top = v, right = v, bottom = v,
      landr = function(self) return self.left + self.right end,
      tandb = function(self) return self.top + self.bottom end
    }
  end
end

return function(element, parent)
  element = element or {}
  return {
    x = 0, y = 0,
    content = { width = 0, height = 0 },
    border = get_rekt(element, "border"),
    margin = get_rekt(element, "margin"),
    padding = get_rekt(element, "padding"),
    parent = parent,
    width = function(self)
      return self.margin:landr() + self.border:landr() + self.padding:landr() + self.content.width
    end,
    height = function(self)
      return self.margin:tandb() + self.border:tandb() + self.padding:tandb() + self.content.height
    end,
    background_position = function(self)
      return self.margin.left + self.border.left, self.margin.top + self.border.top
    end,
    background_size = function(self)
      return self.padding:landr() + self.content.width,
        self.padding:tandb() + self.content.height
    end,
    border_position = function(self)
      return self.margin.left, self.margin.top
    end,
    border_size = function(self)
      return self.border:landr() + self.padding:landr() + self.content.width,
        self.border:tandb() + self.padding:tandb() + self.content.height
    end,
    content_position = function(self)
      return self.margin.left + self.border.left + self.padding.left
      , self.margin.top + self.border.top + self.padding.top
    end,
    region = function(self)
      local r = { left = 0, top = 0 }
      local cx, cy = 0, 0

      if self.parent then
        r = self.parent:region()
        cx = self.parent.padding.left + self.parent.border.left
        cy = self.parent.padding.top + self.parent.border.top
      end

      local bx, by = self:border_position()
      local bw, bh = self:border_size()

      return region(
        r.left + cx + self.x + bx,
        r.top + cy + self.y + by,
        r.left + cx + self.x + bx + bw,
        r.top + cy + self.y + by + bh
      )
    end
  }
end
