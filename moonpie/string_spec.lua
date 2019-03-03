-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("string", function()
  local str = require "moonpie.string"

  it("can split a string on a value", function()
    local s = "I:am:a:string"
    local sp = str.split(s, ":")
    assert.equals("I", sp[1])
    assert.equals("am", sp[2])
    assert.equals("a", sp[3])
    assert.equals("string", sp[4])
  end)

  it("splits on white space by default", function()
    local s = "I am a string"
    local sp = str.split(s)
    assert.equals("I", sp[1])
    assert.equals("am", sp[2])
    assert.equals("a", sp[3])
    assert.equals("string", sp[4])
  end)
end)
