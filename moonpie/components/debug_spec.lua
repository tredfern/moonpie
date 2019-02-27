-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Debug", function()
  local debug = require("moonpie.components").debug

  describe("linking to a debug stats model", function()
    it("renders FPS", function()
      local stats = { fps = function() return 32 end }
      debug({ statistics = stats })
    end)
  end)
end)
