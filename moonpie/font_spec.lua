-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Font", function()
  local mock_love = require "moonpie.test_helpers.mock_love"
  local Font = require "moonpie.font"

  it("is initialized with a font file name", function()
    local f = Font("path_to_file")
    assert.equals("path_to_file", f.name)
  end)

  it("loads a font based on the size of the font when called", function()
    mock_love.mock(love.graphics, "newFont", spy.new(function() return "result!" end))
    local f = Font("path/file_name.ttf")
    local r = f(15)
    assert.spy(love.graphics.newFont).was.called.with("path/file_name.ttf", 15)
    assert.equals("result!", r)
  end)
end)
