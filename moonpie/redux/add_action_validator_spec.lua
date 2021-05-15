-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.redux.add_action_validator", function()
  local addActionValidator = require "moonpie.redux.add_action_validator"

  it("adds a new validator to action if none exists", function()
    local action = {}
    local v = spy.new(function() end)

    addActionValidator(action, v)
    assert.equals(v, action.validate)

  end)

  it("creates a new validator that will process previous validations if one already exists", function()
    local v1 = spy.new(function() return true end)
    local v2 = spy.new(function() return true end)
    local v3 = spy.new(function() return true end)
    local action = {
      validate = v1
    }

    addActionValidator(action, v2)
    addActionValidator(action, v3)

    local state = {}
    action:validate(state)
    assert.spy(v1).was.called_with(action, state)
    assert.spy(v2).was.called_with(action, state)
    assert.spy(v3).was.called_with(action, state)
  end)

  it("returns true for validate if all return true", function()
    local v1 = function() return true end
    local v2 = function() return true end
    local v3 = function() return true end

    local action = { validate = v1 }
    addActionValidator(action, v2)
    addActionValidator(action, v3)

    assert.is_true(action:validate())
  end)

  it("returns false for validate if any return false", function()
    local v1 = function() return true end
    local v2 = function() return false end
    local v3 = function() return true end

    local action = { validate = v1 }
    addActionValidator(action, v2)
    addActionValidator(action, v3)

    assert.is_false(action:validate())
  end)
end)