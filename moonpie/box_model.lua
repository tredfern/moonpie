-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function()
  return {
    x = 0, y = 0,
    content = { width = 0, height = 0 },
    margin = { left = 0, right = 0, top = 0, bottom = 0 },
    width = function(self)
      return self.margin.left + self.content.width + self.margin.right
    end,
    height = function(self)
      return self.margin.top + self.content.height + self.margin.bottom
    end
  }
end
