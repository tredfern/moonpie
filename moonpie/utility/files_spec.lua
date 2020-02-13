-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.files", function()
  local files = require "moonpie.utility.files"

  it("can split out the file name from a path and extension", function()
    local name = files.get_name("path/dir/file.foo")
    assert.equals("file", name)
  end)
end)