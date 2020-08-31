-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.event_system", function()
  local event_system = require "moonpie.event_system"

  it("can have events registered", function()
    event_system.register("my_event")
    assert.is_true(event_system.is_registered("my_event"))
  end)

  it("can have consumers subscribe to events", function()
    event_system.register("my_event")
    event_system.subscribe("my_event", function() end)
  end)

  it("dispatch events", function()
    local s = spy.new(function() end)
    event_system.register("my_event")
    event_system.subscribe("my_event", spy_to_func(s))

    local event = { type = "my_event" }
    event_system.dispatch(event)
    assert.spy(s).was.called_with(event)
  end)
end)