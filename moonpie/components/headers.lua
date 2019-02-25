-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local BASE = (...):match('(.-)[^%.]+$')
local Component = require(BASE .. "component")

Component("header", {
  color = "text"
})

Component.header("header1", {
  margin = 10
})
