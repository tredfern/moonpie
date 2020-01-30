-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  deque = require "moonpie.collections.deque",
  grid = require "moonpie.collections.grid",
  indexed_set = require "moonpie.collections.indexed_set",
  list = require "moonpie.collections.list",
  priority_queue = require "moonpie.collections.priority_queue",
  queue = require "moonpie.collections.queue",
  iterators = {
    cycle = require "moonpie.collections.iterators.cycle",
    filtered = require "moonpie.collections.iterators.filtered",
    random = require "moonpie.collections.iterators.random_iterator",
    reverse = require "moonpie.collections.iterators.reverse",
  },
  randomized_queue = require "moonpie.collections.randomized_queue",
  stack = require "moonpie.collections.stack",
  union_find = require "moonpie.collections.unionfind"
}
