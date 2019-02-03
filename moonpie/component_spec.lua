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

  describe("layout", function()
    it("loops through every control and updates the box model for each control", function()
      local c = component:new()
      local ctrl = { width = 30, height = 12 }
      local ctrl2 = { width = 49, height = 48 }
      c:update(ctrl, ctrl2)

      c:layout()
      assert.equals(30, ctrl.box.area.width)
      assert.equals(12, ctrl.box.area.height)
      assert.equals(49, ctrl2.box.area.width)
      assert.equals(48, ctrl2.box.area.height)
    end)
  end)

  describe("Rendering", function()
    it("goes through every control calling it's render method", function()
      local c = component:new()
      local ctrl = { render = spy.new(function() end) }
      local ctrl2 = { render = spy.new(function() end) }
      c:update(ctrl, ctrl2)
      c:render()
      assert.spy(ctrl.render).was.called()
      assert.spy(ctrl2.render).was.called()
    end)
  end)
end)
