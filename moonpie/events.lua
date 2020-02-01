-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local callback = require "moonpie.callback"
return {
  before_paint = callback:new(),
  after_paint = callback:new(),
  before_update = callback:new(),
  after_update = callback:new()
}