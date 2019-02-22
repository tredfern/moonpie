-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Initialize Moonpie", function()
  require "test_helpers.mock_love"
  local moonpie = require "moonpie"

  it("has an component base", function()
    assert.not_nil(moonpie.component)
  end)

  it("has a text renderer", function()
    assert.not_nil(moonpie.text)
  end)

  it("has a paint", function()
    assert.not_nil(moonpie.paint)
  end)

  it("has a layout method", function()
    assert.not_nil(moonpie.layout)
  end)

  it("has colors", function()
    assert.not_nil(moonpie.colors)
    assert.not_nil(moonpie.colors.red)
  end)

  it("has fonts", function()
    assert.not_nil(moonpie.font)
  end)

  describe("updating", function()
    it("has an update method", function()
      assert.not_nil(moonpie.update)
    end)

    it("updates the mouse each frame", function()
      moonpie.mouse.update = spy.new(function() end)
      moonpie.update()
      assert.spy(moonpie.mouse.update).was.called()
    end)
  end)
end)
