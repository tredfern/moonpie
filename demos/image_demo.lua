-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"

return function()
  return {
      components.image({ source = "assets/images/cat.jpg" }),
      components.image({ source = "assets/images/small.jpg",  width = 200, height = 200 }),
      components.image({ source = "assets/images/big.jpg", width = 300, height = 150 }),
  }
end
