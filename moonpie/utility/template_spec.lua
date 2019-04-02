-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Template", function()
  local template = require "moonpie.utility.template"

  it("can replace things inside handlebars with values", function()
    local t = "{{foo}}"
    assert.equals("bar", template(t, { foo = "bar" }))
  end)

  it("can work in more complex scenarios", function()
    local t = "Hello {{name}}!"
    assert.equals("Hello Bob!", template(t, { name = "Bob" }))
  end)

  it("returns nil if template is nil", function()
    assert.is_nil(template(nil, {}))
  end)
end)
