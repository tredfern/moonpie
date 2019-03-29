-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(l, t, r, b)
  return setmetatable({
    left = l,
    right = r,
    top = t,
    bottom = b,

    contains = function(self, x, y)
      return x >= self.left and x <= self.right and
        y >= self.top and y <= self.bottom
    end
  }, {
    __tostring = function(tbl)
        return string.format("Region (%d,%d)-(%d,%d)", tbl.left, tbl.top, tbl.right, tbl.bottom)
    end
  })
end
