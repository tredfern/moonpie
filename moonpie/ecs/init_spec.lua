-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ecs", function()
  local ecs = require "moonpie.ecs"

  it("provides a method for creating a new world", function()
    local world = ecs.world:new()
    assert.not_nil(world)
  end)
end)