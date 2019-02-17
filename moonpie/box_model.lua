-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function get_rekt(element, property)
  if type(element[property]) == "table" then
    return {
      left = element[property].left or 0,
      top = element[property].top or 0,
      right = element[property].right or 0,
      bottom = element[property].bottom or 0,
    }
  else
    local v = tonumber(element[property]) or 0
    return {
      left = v, top = v, right = v, bottom = v
    }
  end
end

return function(element)
  element = element or {}
  return {
    x = 0, y = 0,
    content = { width = 0, height = 0 },
    margin = get_rekt(element, "margin"),
    padding = get_rekt(element, "padding"),
    width = function(self)
      return self.margin.left + self.padding.left + self.content.width + self.padding.right + self.margin.right
    end,
    height = function(self)
      return self.margin.top + self.padding.top + self.content.height + self.padding.bottom + self.margin.bottom
    end,
    background_position = function(self)
      return self.margin.left, self.margin.top
    end,
    background_size = function(self)
      return self.padding.left + self.content.width + self.padding.right,
        self.padding.top + self.content.height + self.padding.bottom
    end,
    content_position = function(self)
      return self.margin.left + self.padding.left, self.margin.top + self.padding.top
    end,
    region = function(self)
      local r = { left = 0, top = 0 }
      if self.parent then r = self.parent:region() end
      return {
        left = r.left + self.x,
        top = r.top + self.y,
        right = r.left + self.x + self:width(),
        bottom = r.top + self.y + self:height()
      }
    end
  }
end
