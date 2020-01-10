-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("ScriptTools", function()
  local ScriptTools = require "moonpie.utility.script_tools"
  it("can get the location that a script is running", function()
    assert.equals("./moonpie/utility/", ScriptTools.get_path())
  end)
end)