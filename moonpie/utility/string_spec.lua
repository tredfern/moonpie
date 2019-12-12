-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("string", function()
  local str = require "moonpie.utility.string"

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

  it("inserts a string at an index", function()
    local s = "I am a string"
    local ins = str.insert(s, 4, "-hello-")
    assert.equals("I am-hello- a string", ins)
  end)

  it("insert to the start of the string properly", function()
    local s = "I am string"
    local ins = str.insert(s, 0, "-hello-")
    assert.equals("-hello-I am string", ins)
  end)
end)
