-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Alignment", function()
  local align = require "moonpie.ui.alignment"

  it("align left uses the smallest value possible", function()
    local x = align("left", 10, 50, 5)
    assert.equals(10, x)
  end)

  it("align right returns the maximum minus the width", function()
    local x = align("right", 10, 50, 5)
    assert.equals(45, x)
  end)

  it("takes the difference when aligning to the center", function()
    local x = align("center", 10, 50, 5)
    assert.equals(17.5, x)
  end)

  it("align top uses the smallest value possible", function()
    local y = align("top", 10, 50, 5)
    assert.equals(10, y)
  end)

  it("aligns bottom to the maximum minus the height", function()
    local y = align("bottom", 10, 50, 5)
    assert.equals(45, y)
  end)

  it("aligns middle to the difference and half left over", function()
    local y = align("middle", 10, 50, 5)
    assert.equals(17.5, y)
  end)
end)
