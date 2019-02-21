-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local find_by_coordinates = require(BASE .. "find_by_coordinates")

return {

  update = function(self, layout)
    self.x, self.y = love.mouse.getPosition()
    self.over_components = find_by_coordinates(self.x, self.y, layout)
  end
}
