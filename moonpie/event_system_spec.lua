-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.utility.event_system", function()
  local event_system = require "moonpie.event_system"

  it("dispatch events", function()
    local s = spy.new(function() end)
    event_system.subscribe("my_event", spy_to_func(s))

    local event = { type = "my_event" }
    event_system.dispatch(event)
    assert.spy(s).was.called_with(event)
  end)

  it("raises a clear error if the event triggered has no queue", function()
    assert.has_no_error(function()
      event_system.dispatch({ type = "missing_event" })
    end)
  end)
end)