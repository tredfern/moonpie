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
    assert.spy(s1.update).was.called_with(s1)
    assert.spy(s2.draw).was_not.called()
    assert.spy(s3.update).was.called_with(s3)

    test_world:process("draw")
    assert.spy(s2.draw).was.called_with(s2)
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
end)