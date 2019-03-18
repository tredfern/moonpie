-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.components"

return function()
  return {
      components.image({ src = "assets/images/cat.jpg" }),
      components.image({ src = "assets/images/small.jpg",  width = 200, height = 200 }),
      components.image({ src = "assets/images/big.jpg", width = 300, height = 150 }),
  }
end
