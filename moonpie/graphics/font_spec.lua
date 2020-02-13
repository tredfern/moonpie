-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Font", function()
  local mock_love = require "moonpie.test_helpers.mock_love"
  local Font = require "moonpie.graphics.font"

  it("tracks the full path name for the font", function()
    local f = Font("assets/some/value/path_to_file.ttf")
    assert.equals("assets/some/value/path_to_file.ttf", f.path)
  end)

  it("is initialized with a font file name", function()
    local f = Font("assets/some/value/path_to_file.ttf")
    assert.equals("path_to_file", f.name)
  end)

  it("registers the font for lookup", function()
    Font("assets/foo/bar/stored.ttf")
    assert.is_table(Font.registered.stored)
  end)

  it("returns the same font if an identical path is called", function()
    local f = Font("assets/some/value/path_to_file.ttf")
    local f2 = Font("assets/some/value/path_to_file.ttf")
    assert.equals(f, f2)
  end)

  it("loads a font based on the size of the font when called", function()
    mock_love.mock(love.graphics, "newFont", spy.new(function() return "result!" end))
    local f = Font("path/file_name.ttf")
    local r = f(15)
    assert.spy(love.graphics.newFont).was.called.with("path/file_name.ttf", 15)
    assert.equals("result!", r)
  end)
end)
