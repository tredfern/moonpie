-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.tables.same", function()
  local same = require "moonpie.tables.same"

  it("makes sure that the two tables have the equal values in the same index", function()
    local t1 = {1, 2, 3}
    local t2 = {1, 2, 3}
    local t3 = {3, 2, 1}
    local t4 = {4, 3, 2, 1}

    assert.is_true(same(t1, t2))
    assert.is_false(same(t1, t3))
    assert.is_false(same(t1, t4))
  end)

  it("returns true if both are nil", function()
    assert.is_true(same(nil, nil))
  end)

  it("returns false if one of them is nil", function()
    assert.is_false(same({}, nil))
    assert.is_false(same(nil, {}))
  end)

end)