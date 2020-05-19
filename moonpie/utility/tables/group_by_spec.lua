-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.tables.group_by", function()
  local tables = require "moonpie.utility.tables"

  it("can group bys items with the same value", function()
    local set = { 1, 1, 1, 2, 3, 3, 4 }
    local result = tables.group_by(set)
    assert.equals(4, #result)
    assert.equals(3, #result[1])
    assert.equals(1, #result[2])
    assert.equals(2, #result[3])
    assert.equals(1, #result[4])
  end)

  it("can take a property to group by", function()
    local set = {
      { value = "a" },
      { value = "a" },
      { value = "b" },
      { value = "c" },
      { value = "c" },
    }

    local result = tables.group_by(set, "value")
    assert.equals(2, #result["a"])
    assert.equals(1, #result["b"])
    assert.equals(2, #result["c"])
  end)

  it("can take a function to group by", function()
    local set = { 1, 2, 3, 4, 5 }
    local result = tables.group_by(
      set,
      function(v)
        if v % 2 == 0 then
          return "even"
        else
          return "odd"
        end
      end
    )
    assert.equals(3, #result["odd"])
    assert.equals(2, #result["even"])
  end)

  it("ignores any key that returns nil", function()
    local set = { 1, 1, 2, 2, 3, 3, 3, 3 }
    local result = tables.group_by(set, function(v) if v ~= 3 then return v end end)
    assert.is_nil(result[3])
  end)
end)