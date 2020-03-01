-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.test_helpers.file_assertions", function()
  it("can assert that a file exists", function()
    assert.file_exists("moonpie/test_helpers/file_assertions.lua")
    assert.not_file_exists("some/totally_random/file/name.foo")
  end)

end)