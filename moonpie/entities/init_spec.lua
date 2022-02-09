-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.entities", function()
  local Entities = require "moonpie.entities"
  local MockStore = require "moonpie.test_helpers.mock_store"

  it("register for the beforeUpdate event and processes all the systems that are registered", function()
    local s = spy.new(function() end)
    local state = {
      entities = {
        { a = 1 }, { a = 2 }, { b = 3 }, { a = 4 },
        systems = { s },
        filters = { [s] = { "a" }}
      },
    }
    MockStore(state)
    Entities.processUpdate()

    assert.spy(s).was.called_with({ { a = 1 }, { a = 2 }, { a = 4 }})
  end)
end)