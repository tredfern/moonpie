-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local find_by_coordinates = require("moonpie.find_by_coordinates")

local BUTTON_COUNT = 4

return setmetatable({
  button_states = {},
  button_down_components = {},
  button_up_components = {},

  check_primary_button = function(self)
    -- check primary button state
    if self.isDown(1) and not self.button_states[1] then
      self.button_down_components[1] = self.over_components
    elseif not self.isDown(1) and self.button_states[1] then
      self.button_up_components[1] = self.over_components
      self:trigger_click()
    end
  end,
  trigger_click = function(self)
    -- start in the lowest component and search up
    for i = #self.button_up_components[1], 1, -1 do
      if self.button_up_components[1][i].click then
        self.button_up_components[1][i]:click()
      end
    end
  end,
  update_button_states = function(self)
    for i=1,BUTTON_COUNT do
      self.button_states[i] = self.isDown(i)
    end
  end,

  update = function(self, layout)
    self.current_layout = layout
    self.x, self.y = self.getPosition()
    self.over_components = find_by_coordinates(self.x, self.y, self.current_layout)

    self:check_primary_button()
    self:update_button_states()
  end
} ,
{
  __index = love.mouse
})
