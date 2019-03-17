-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return setmetatable({
  hot_keys = {},
  key_down = {},
  hotkey = function(self, key, callback)
    self.hot_keys[key] = callback
  end,

  reset = function(self)
    self.hot_keys = {}
    self.key_down = {}
  end,

  update = function(self)
    for k, v in pairs(self.hot_keys) do
      if self.isDown(k) then
        if not self.key_down[k] then
          v()
          self.key_down[k] = true
        end
      else
        self.key_down[k] = nil
      end
    end
  end
},{
  __index = love.keyboard
})
