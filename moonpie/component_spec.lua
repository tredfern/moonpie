-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Component", function()
  local component = require "moonpie.component"

  describe("Updating a component", function()
    it("can add controls that are just plain functions", function()
      local c = component:new()
      local ctrl = function() end
      c:update(ctrl)
      assert.equals(1, #c.children)
      assert.equals(ctrl, c.children[1])
    end)
  end)

  describe("Rendering", function()
    it("goes through every control calling it's render method", function()
      local c = component:new()
      local ctrl = spy.new(function() end)
      local ctrl2 = spy.new(function() end)
      c:update(ctrl, ctrl2)
      c:render()
      assert.spy(ctrl).was.called()
      assert.spy(ctrl2).was.called()
    end)
  end)
end)
