-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.statistics", function()
  local stats = require "moonpie.statistics"

  it("can update stats", function()
    stats.update("val", 5)
    assert.equals(5, stats["val"])
    stats.update("val", 5)
    assert.equals(10, stats["val"])
  end)

end)