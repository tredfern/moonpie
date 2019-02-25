-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local Component = require(BASE .. "component")

return Component("vertical_scrollbar", {
  minimum = 0,
  maximum = 100,
  increment = 1,
  __current = 0,

  current_position = function(self)
    -- ensure range
    self.__current = math.min(self.__current, self.maximum)
    self.__current = math.max(self.__current, self.minimum)
    return self.__current
  end,

  scroll_down = function(self)
    self.__current = self:current_position() + self.increment
  end,

  scroll_up = function(self)
    self.__current = self:current_position() - self.increment
  end,

  set_position = function(self, v)
    self.__current = v
  end
})
