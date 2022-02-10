-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.class", function()
  local class = require "moonpie.class"

  it("can pass initialization values to a constructor", function()
    local sample = class("test3")
    sample.initialize = function(self, x, y)
        self.x = x
        self.y = y
      end

    local instance = sample:new(1, 2)
    assert.equals(1, instance.x)
    assert.equals(2, instance.y)
  end)

  it("supports easy tostring override", function()
    local c = class("test4")
    c.__tostring = function(self) return "mystring" .. self.text end

    local v = c:new()
    v.text = "some"

    assert.equals("mystringsome", tostring(v))
  end)
end)