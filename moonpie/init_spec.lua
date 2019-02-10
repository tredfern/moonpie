-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Initialize Moonpie", function()
  require "test_helpers.mock_love"
  local moonpie = require "moonpie"

  it("has an component base", function()
    assert.not_nil(moonpie.component)
  end)

  it("has a text element", function()
    assert.not_nil(moonpie.text)
  end)

  it("has a renderer", function()
    assert.not_nil(moonpie.renderer)
  end)

end)
