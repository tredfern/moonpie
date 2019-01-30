-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Initialize Moonpie", function()
  local moonpie = require "moonpie"

  it("has an component base", function()
    assert.not_nil(moonpie.component)
  end)

end)
