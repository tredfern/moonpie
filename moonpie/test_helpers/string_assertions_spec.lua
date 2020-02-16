-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.test_helpers.string_assertions", function()
  it("can check if a string contains a string", function()
    assert.contains("ab", "foo-ab-bar")
    assert.not_contains("ab", "foobar")
  end)

  it("returns true if the whole string matches", function()
    assert.contains("align%-center", "align-center")
  end)
end)