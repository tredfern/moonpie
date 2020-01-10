-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Conf", function()
  local Conf = require "moonpie.conf"

  it("has an assets directory location", function()
    assert.equals("./moonpie/assets/", Conf.assets_path)
  end)
end)