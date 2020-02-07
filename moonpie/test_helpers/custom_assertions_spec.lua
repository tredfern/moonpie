-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.test_helpers.custom_assertions", function()
  it("can just fail", function()
    assert.is_not.fail()
  end)

end)