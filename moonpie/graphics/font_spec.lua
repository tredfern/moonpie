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

  it("can get a font of a name and size in a single call", function()
    mock_love.mock(love.graphics, "newFont", spy.new(function() return "result!" end))
    Font("assets/font.ttf")
    local r = Font("font", 15)
    assert.equals("result!", r)
    assert.spy(love.graphics.newFont).was.called.with("assets/font.ttf", 15)
  end)

  it("can alias the font to another name", function()
    local f = Font:register("path/file_name.ttf", "default")
    assert.not_nil(Font.registered["default"])
    assert.equals(f, Font("default"))
  end)

  it("can register an alias to a registered font", function()
    local f = Font:register("path/file_name.ttf")
    local f2 = Font:register("path/file_name.ttf", "default")
    assert.equals(f, f2)
    assert.equals(f, Font("default"))
  end)

  describe("helpers", function()
    it("returns a tables font property if defined", function()
      local tbl = { font = "foobar" }
      assert.equals("foobar", Font.pick(tbl))
    end)

    it("loads from registered fonts based on name and size", function()
      local tbl = { font_name = "arial", font_size = 12 }
      local b = Font("arial", 12)
      assert.equals(b, Font.pick(tbl))
    end)

    it("returns the not-set font with a size of 12 if it cannot find anything in the table", function()
      local t = Font:register("some_font", "not-set")
      local def = t(12)
      local misconfigured = Font.pick({})
      assert.equals(def, misconfigured)
    end)
  end)
end)
