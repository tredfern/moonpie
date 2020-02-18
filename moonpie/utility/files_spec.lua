-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.files", function()
  local files = require "moonpie.utility.files"
  local config = require "moonpie.configuration"

  it("can split out the file name from a path and extension", function()
    local name = files.get_name("path/dir/file.foo")
    assert.equals("file", name)
  end)

  it("can search a directory and return all files", function()
    local list = files.find(config.icons_path)
    assert.greater_than(3000, #list)
  end)

  it("can search a directory and return files that match a pattern", function()
    local list = files.find(config.icons_path, "card%-2")
    assert.equals(4, #list)
  end)

  it("property builds the directory when appending the file", function()
    local list = files.find(config.icons_path, "acrobatic")
    assert.equals("./moonpie/assets/icons/darkzaitzev/acrobatic.png", list[1])
  end)

  it("can merge path intelligently", function()
    assert.equals("assets/foo/bar.ggg", files.merge_path("assets/foo/", "bar.ggg"))
    assert.equals("assets/foo/bar.ggg", files.merge_path("assets/foo", "bar.ggg"))
  end)
end)