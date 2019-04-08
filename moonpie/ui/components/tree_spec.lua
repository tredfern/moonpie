-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Tree", function()
  local components = require "moonpie.ui.components"

  it("creates a sequence of components based on a table tree", function()
    local t = components.tree({
      tree = {
        leaf = components.text({ id = "root", text = "root" }),
        {
          leaf = components.text({ id = "foo-1", text = "foo-1" }),
          {
            leaf = components.text({ id = "foo-1-1", text = "foo-1-1" })
          },
          {
            leaf = components.text({ id = "foo-1-2", text = "foo-1-2" })
          }
        },
        {
            leaf = components.text({ id = "foo-2", text = "foo-2" }),
            {
              leaf = components.text({ id = "foo-2-1", text = "foo-2-1" }),
            }
        }
      }
    })

    assert.is_true(#t > 0)
    assert.not_nil(t:find_by_id("root"))
    assert.not_nil(t:find_by_id("foo-2-1"))
    local n = t:find_by_id("foo-1-2")
    assert.equals("foo-1-2", n.text)
  end)
end)