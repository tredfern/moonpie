-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Colors", function()
  local colors = require "moonpie.graphics.colors"
  it("can convert rgb hex values to integer rgb", function()
    local c = colors.convert_hex("#FFFFFF")
    assert.array_matches({1.0, 1.0, 1.0, 1}, c)

    c = colors.convert_hex("#FFF")
    assert.array_matches({1.0, 1.0, 1.0, 1}, c)

    c = colors.convert_hex("#0D0D0D")
    local target = tonumber("0x0D")/255
    assert.array_matches({ target, target, target, 1 }, c)
  end)

  it("can process a function to generate a color", function()
    local light_red = colors(function() return colors.lighten(colors("red"), 1.2) end)
    assert.equals(4, #light_red)
    assert.is_true(light_red[1] > 0)
  end)

  it("will lookup the color if necessary to lighten it", function()
    colors.lightenTest = "red"
    local clr = colors.lighten(colors.lightenTest, 1.2)
    assert.is_true(clr[1] > 0)
  end)

  it("can decipher whether the passed in value is a color or a lookup", function()
    colors.some_color = {1, 1, 1, 1}
    assert.same(colors.some_color, colors("some_color"))
    assert.same(colors.red, colors(colors.red))
  end)

  it("can call several layers to find the original color", function()
    colors.some_color = {1, 1, 1, 1}
    colors.referrer = "some_color"
    assert.same(colors.some_color, colors("referrer"))
  end)

  it("does not redistribute any values if less or equals to 1.0", function()
    local clr = colors.redistribute_rgb({ 1, 0.6, 1.0, 0.6 })
    assert.equals(1, clr[1])
    assert.equals(0.6, clr[2])
    assert.equals(1, clr[3])
  end)

  it("can redistribute the r, g, b, values after threshold to keep things balanced", function()
    local satur = { 1.2, 0.4, 1.1, 1 }
    local clr = colors.redistribute_rgb(satur)
    assert.equals(1, clr[1])
    -- TODO: other asserts are challenging with floats...
  end)

  it("can returns white if you are just off the limits", function()
    local clr = colors.redistribute_rgb({ 4, 20, 23, 1 })
    assert.equals(1, clr[1])
    assert.equals(1, clr[2])
    assert.equals(1, clr[3])
    assert.equals(1, clr[4])
  end)

  it("can lighten the color", function()
    local c = colors.lighten({0.4, 0.2, 0.5, 1 }, 1.2)
    assert.is_true(0.4 < c[1])
    assert.is_true(0.2 < c[2])
    assert.is_true(0.5 < c[3])
    assert.equals(1, c[4])
  end)

  it("can adjust the opacity if provided", function()
    local c = colors("red", 0.5)
    assert.same({1, 0, 0, 0.5 }, c)
  end)

  it("has a transparent color", function()
    local c = colors("transparent")
    assert.same({0,0,0,0}, c)
  end)

  it("can get a list of only the colors", function()
    local clrs = colors.all()
    for _, v in ipairs(clrs) do
      assert.equals("table", type(v))
      assert.equals(4, #v)
      assert.equals("number", type(v[1]))
      assert.equals("number", type(v[2]))
      assert.equals("number", type(v[3]))
      assert.equals("number", type(v[4]))
    end
  end)
end)
