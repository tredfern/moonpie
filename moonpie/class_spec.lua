-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.class", function()
  local class = require "moonpie.class"

  it("can turn any table into something that can be instantiated", function()
    local sample = class:subclass({
      f = spy.new(function() end),
      v = 123
    })
    local instance = sample()
    instance:f()
    assert.spy(sample.f).was.called_with(instance)
    assert.equals(123, instance.v)
  end)

  it("things have different member values", function()
    local sample = class:subclass({
      v = 123,
      f = function(self, add) return self.v + add end
    })

    local instance1 = sample()
    local instance2 = sample()
    instance1.v = 13
    instance2.v = 39
    assert.equals(17, instance1:f(4))
    assert.equals(43, instance2:f(4))
  end)

  it("can pass initialization values to a constructor", function()
    local sample = class:subclass({
      constructor = function(self, x, y)
        self.x = x
        self.y = y
      end
    })

    local instance = sample(1, 2)
    assert.equals(1, instance.x)
    assert.equals(2, instance.y)
  end)
end)