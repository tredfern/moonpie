-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.math.ipoint", function()
  local iPoint = require "moonpie.math.ipoint"

  it("creates a point that is read-only", function()
    local p = iPoint(3, 2, 1)
    assert.has_errors(function() p.x = 84 end)
  end)

  it("enforces coordinates to be integers", function()
    local p = iPoint(3.2, 9.4, 2.2)
    assert.equals(3, p.x)
    assert.equals(9, p.y)
    assert.equals(2, p.z)
  end)

  it("creates a repeatable hash key based on coordinates", function()
    local key = iPoint.createHashKey(35, 29, 100)
    assert.equals(key, iPoint.createHashKey(35, 29, 100))
    assert.not_equal(key, iPoint.createHashKey(36, 29, 100))
  end)

  it("utilizes a cache of points to return the same point each time", function()
    local p = iPoint(3, 3, 3)
    local p2 = iPoint(3, 3, 3)
    assert.equals(p, p2)
  end)

  it("can add to end up in a different point", function()
    local p = iPoint(3, 3, 3)
    local p2 = iPoint.add(p, 1, -1, 2)
    assert.equals(4, p2.x)
    assert.equals(2, p2.y)
    assert.equals(5, p2.z)
  end)


  it("doesn't collide for the first 200x200x200", function()
    pending("Ignore this test, just use it for testing for hash-collisions manually")
    local p = {}
    for x = 1,200 do
      for y = 1,200 do
        for z= 1,200 do
          local l = iPoint(x, y, z)
          assert.is_nil(p[l.hashKey])
          p[l.hashKey] = l
        end
      end
    end
  end)
end)