-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("math_ext", function()
  local math_ext = require "moonpie.math_ext"
  it("can clamp a value to a range", function()
    assert.equals(4, math_ext.clamp(4, 1, 10))
    assert.equals(1, math_ext.clamp(0, 1, 10))
    assert.equals(1, math_ext.clamp(0.9999, 1, 10))
    assert.equals(10, math_ext.clamp(10.000000001, 1, 10))
    assert.equals(10, math_ext.clamp(10, 1, 10))
  end)
end)
