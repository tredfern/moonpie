-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ui.update_queue", function()
  local update_queue = require "moonpie.ui.update_queue"

  it("can add components to the queue", function()
    local c = {}
    update_queue:push(c)
  end)

  it("can process items from the queue", function()
    local c = {}
    update_queue:push(c)
    assert.equals(c, update_queue:pop())
  end)
end)