-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.pack", function()
  local pack = require "moonpie.tables.pack"

  it("puts args into a table that can be used", function()
    local function packme(...) return pack(...) end
    assert.array_matches({1,2,3,4,5}, packme(1,2,3,4,5))
  end)


  it("contains a count of all the arguments that are packed", function()
    local packed = pack(1, 2, 3, nil, 5, 6, nil, 8)
    assert.equals(8, packed.n)
  end)
end)