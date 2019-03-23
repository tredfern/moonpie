-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Sleep", function()
  local sleep = require "moonpie.utility.sleep"

  it("waits for a certain number of milliseconds before returning", function()
    local start = os.clock()
    sleep(0.01)
    local stop = os.clock()
    assert.near(0.01, stop - start,  0.006)
  end)
end)
