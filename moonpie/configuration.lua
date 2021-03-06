-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ScriptTools = require "moonpie.utility.script_tools"
local Conf = {}

Conf.assets_path = ScriptTools.getPath() .. "assets/"
Conf.icons_path = Conf.assets_path .. "icons/"

return Conf