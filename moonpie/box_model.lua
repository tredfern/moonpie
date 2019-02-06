-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function()
  return {
    x = 0, y = 0,
    content = { width = 0, height = 0 },
    width = function(self) return self.content.width end,
    height = function(self) return self.content.height end
  }
end
