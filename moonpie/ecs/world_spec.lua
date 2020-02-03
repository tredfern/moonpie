-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.ecs.world", function()
  local world = require "moonpie.ecs.world"
  local test_world

  before_each(function()
    test_world = world:new()
  end)

  it("allows adding systems to the world", function()
    test_world:add_systems({})
    assert.equals(1, #test_world.systems)
  end)

  it("can add multiple systems", function()
    test_world:add_systems({}, {}, {})
    assert.equals(3, #test_world.systems)
  end)

  it("can process a method on systems that support that method", function()
    local s1 = { update = spy.new(function() end) }
    local s2 = { draw = spy.new(function() end) }
    local s3 = { update = spy.new(function() end) }

    test_world:add_systems(s1, s2, s3)
    test_world:process("update")
    assert.spy(s1.update).was.called_with(s1, love.timer.getDelta())
    assert.spy(s2.draw).was_not.called()
    assert.spy(s3.update).was.called_with(s3, love.timer.getDelta())

    test_world:process("draw")
    assert.spy(s2.draw).was.called_with(s2, love.timer.getDelta())
  end)

  it("queues entities to add to the world", function()
    test_world:add_entities({}, {}, {}, {})
    assert.equals(4, #test_world.queued_entities)
  end)

  it("updates filter groups during process method", function()
    local s = { filter = function(e) return e.is_good_guy end }
    local gg = { is_good_guy = true }
    local bg = { is_bad_guy = true }
    test_world:add_systems(s)
    test_world:add_entities(gg, bg)
    test_world:process("update")
    assert.is_true(test_world.filter_groups[s.filter]:contains(gg))
    assert.is_false(test_world.filter_groups[s.filter]:contains(bg))
  end)

  it("provides the delta time to the system for processing", function()
    local s = {
      filter = function(e) return e.is_good_guy end,
      update = spy.new(function() end)
    }
    local gg = { is_good_guy = true }
    local bg = { is_bad_guy = true }
    test_world:add_systems(s)
    test_world:add_entities(gg, bg)
    test_world:process("update")
    assert.spy(s.update).was.called_with(s, test_world.filter_groups[s.filter], love.timer.getDelta())
  end)

  it("process event sets the system entities to ones that pass the filter", function()
    local ent
    local s = {
      filter = function(e) return e.is_good_guy end,
      update = spy.new(function(_, entities) ent = entities end)
    }
    local gg = { is_good_guy = true }
    local bg = { is_bad_guy = true }
    test_world:add_systems(s)
    test_world:add_entities(gg, bg)
    test_world:process("update")
    assert.is_true(ent:contains(gg))
    assert.is_false(ent:contains(bg))
  end)

  it("does not process queued entities a second time after process", function()
    local ent = {}
    test_world:add_entities(ent)
    test_world:process("event")
    test_world:process("event")
    test_world:process("event")
    assert.equals(0, #test_world.queued_entities)
  end)

  it("adds all existing entities through a new filter group if system added", function()
    local gg = { gg = true }
    local bg = { bg = true }
    test_world:add_entities(gg, bg)
    test_world:process("foo")
    assert.is_true(test_world.queued_entities:isempty())

    local s = {
      filter = function(e) return e.bg end
    }
    test_world:add_systems(s)
    assert.equals(1, #test_world.filter_groups[s.filter])
  end)

  it("passes the delta time into each system", function()
    local s = { update = spy.new(function() end) }
    test_world:add_systems(s)
    test_world:process("update")
    assert.spy(s.update).was.called_with(s, love.timer.getDelta())
  end)
end)