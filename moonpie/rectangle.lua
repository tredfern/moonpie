-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local rectangle = {}

function rectangle:new(props)
  props = props or {}
  local rect = {
    x = props.x or 0,
    y = props.y or 0,
    width = props.width or 0,
    height = props.height or 0
  }
  self.__index = self
  setmetatable(rect, self)
  return rect
end

function rectangle:left()
  return self.x
end

function rectangle:right()
  return self.x + self.width
end

function rectangle:top()
  return self.y
end

function rectangle:bottom()
  return self.y + self.height
end

return setmetatable(rectangle,
  {
    __index = rectangle,
    __call = function(...) return rectangle.new(...) end
  }
)


