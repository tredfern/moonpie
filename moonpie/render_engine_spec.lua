-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Render Engine", function()
  local RenderEngine = require "moonpie.render_engine"

  it("tracks all the components that have been added to it", function()
    local ele1, ele2, ele3 = {}, {}, {}
    local r = RenderEngine(ele1, ele2, ele3)
    assert.equals(3, #r.tree)
  end)

  it("rendering returns tables as they are", function()
    local ele1, ele2 = {}, {}
    local r = RenderEngine(ele1, ele2)
    local output = r:render()
    assert.equals(ele1, output[1])
    assert.equals(ele2, output[2])
  end)

  it("calls any function that has been added and adds it's result to the layout tree", function()
    local ele = {}
    local comp = function() return ele end
    local r = RenderEngine(comp)
    local output = r:render()
    assert.equals(ele, output[1])
  end)

  it("recursively adds tables", function()
    local ele = {}
    local parent = { ele }
    local r = RenderEngine(parent)
    local output = r:render()
    assert.equals(parent, output[1])
    assert.equals(ele, output[1][1])
  end)
end)
