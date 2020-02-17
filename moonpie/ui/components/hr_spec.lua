-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.components.hr", function()
  require "moonpie.ui.components.hr"

  it("defines an hr component", function()
    local components = require "moonpie.ui.components"
    local hr = components.hr()
    assert.not_nil(hr)
  end)
end)