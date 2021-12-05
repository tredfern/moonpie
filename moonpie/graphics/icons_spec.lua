-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.graphics.icons", function()
  local icons = require "moonpie.graphics.icons"

  it("it loads the icon directory at tracks the file and icon-name", function()
    local i = icons.get("abstract-108")
    assert.equals("./moonpie/assets/icons/abstract-108.png", i)
  end)

  it("loaded these icons", function()
    assert.not_nil(icons.get("amplitude"))
  end)
end)