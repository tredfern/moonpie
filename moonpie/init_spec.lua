-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Initialize Moonpie", function()
  require "test_helpers.mock_love"
  local moonpie = require "moonpie"

  it("has an components base", function()
    assert.not_nil(moonpie.components)
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

    it("refreshes the layout of the gui if it is dirty", function()
      local c = moonpie.components("node", { })
      local tree = moonpie.layout(c)
      c:modify({ })
      tree.layout = spy.new(function() end)
      moonpie.update()
      assert.spy(tree.layout).was.called()
    end)
  end)
end)
