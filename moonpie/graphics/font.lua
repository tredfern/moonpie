-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(path)
  return setmetatable({
    name = path,
  }, {
    __call = function(self, size)
      if not self[size] then
        self[size] = love.graphics.newFont(self.name, size)
      end
      return self[size]
    end
  })
end
