-- Copyright (c) 2019 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - List", function()
  local Components = require "moonpie.ui.components"

  it("takes a list of string items and will display them as text", function()
    local list = Components.list({ items = { "one", "two", "three", "four" }})
    local item1 = list:find_by_id("list_item_1")
    assert.equals("one", item1[1].text)
    local item2 = list:find_by_id("list_item_2")
    assert.equals("two", item2[1].text)
    local item3 = list:find_by_id("list_item_3")
    assert.equals("three", item3[1].text)
  end)

  it("can support custom list item types", function()

    local list = Components.list({
      items = {
        Components.button({ id = "btn_1", caption = "one", click = function() end }),
        Components.button({ id = "btn_2", caption = "two", click = function() end }),
      }
    })

    assert.equals(2, #list)
    local item1 = list:find_by_id("btn_1")
    assert.equals("one", item1.caption)
    assert.not_nil(item1.click)
  end)

  it("can have custom ids if specified", function()
    local list = Components.list({
      items = {
        Components.button({ id = "my_id", caption = "one" })
      }
    })
    assert.not_nil(list:find_by_id("my_id"))
  end)

  it("wraps each item with in a list_item component", function()
    local list = Components.list({
      items = { "one", "two", "three" }
    })

    assert.equals("list_item", list:find_by_id("list_item_1").name)
  end)
end)