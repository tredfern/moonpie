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
end)
