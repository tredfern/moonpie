-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Colors", function()
  require "test_helpers.mock_love"

  local colors = require "moonpie.colors"
  it("can convert rgb hex values to integer rgb", function()
    local r,g,b = colors.convert_hex("#FFFFFF")
    assert.is.equal(1, r)
    assert.is.equal(1, g)
    assert.is.equal(1, b)

    r, g, b = colors.convert_hex("#FFF")
    assert.is.equal(1, r)
    assert.is.equal(1, g)
    assert.is.equal(1, b)

    r, g, b = colors.convert_hex("#0D0D0D")
    local target = tonumber("0x0D")/255
    assert.is.equal(target, r)
    assert.is.equal(target, g)
    assert.is.equal(target, b)
  end)

  it("can decipher whether the passed in value is a color or a lookup", function()
    colors.some_color = {1, 1, 1, 1}
    assert.equals(colors.some_color, colors("some_color"))
    assert.equals(colors.red, colors(colors.red))
  end)

  it("can call several layers to find the original color", function()
    colors.some_color = {1, 1, 1, 1}
    colors.referrer = "some_color"
    assert.equals(colors.some_color, colors("referrer"))
  end)
end)
