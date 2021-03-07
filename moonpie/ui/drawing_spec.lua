-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Renderers", function()
  local match = require "luassert.match"
  local mock_love = require "moonpie.test_helpers.mock_love"
  local drawing = require "moonpie.ui.drawing"
  local Node = require "moonpie.ui.node"

  before_each(function()
    mock_love.mock(love.graphics, "push", spy.new(function() end))
    mock_love.mock(love.graphics, "pop", spy.new(function() end))
    mock_love.mock(love.graphics, "translate", spy.new(function() end))
    mock_love.mock(love.graphics, "setColor", spy.new(function() end))
    mock_love.mock(love.graphics, "rectangle", spy.new(function() end))
    mock_love.mock(love.graphics, "setLineWidth", spy.new(function() end))
    mock_love.mock(love.graphics, "draw", spy.new(function() end))
  end)

  it("does nothing if flagged as hidden", function()
    local b = Node({ hidden = true, width = 100, height = 100, backgroundColor = "red" })
    drawing.standard(b)
    assert.spy(love.graphics.push).was.not_called()
    assert.spy(love.graphics.translate).was.not_called()
    assert.spy(love.graphics.rectangle).was.not_called()
    assert.spy(love.graphics.setLineWidth).was.not_called()
    assert.spy(love.graphics.setColor).was.not_called()
    assert.spy(love.graphics.pop).was.not_called()
  end)

  describe("Painting", function()
    it("translates its position to the x, y position", function()
      local b = Node()
      b.box.x = 39
      b.box.y = 59

      drawing.standard(b)
      assert.spy(love.graphics.push).was.called()
      assert.spy(love.graphics.translate).was.called_with(39, 59)
      assert.spy(love.graphics.pop).was.called()
    end)

    it("paints each of its children", function()
      local b = Node()
      local spy_paint = spy.new(function() end)
      local c1 = Node({ paint = spy_paint })
      local c2 = Node({ paint = spy_paint })

      b:add(c1, c2)
      drawing.standard(b)
      assert.spy(spy_paint).was.called(2)
    end)

    it("translates to where the background is to draw the background", function()
      local b = Node{ margin = 5, padding = 4, backgroundColor = {1, 1, 1, 1 } }

      drawing.standard(b)
      assert.spy(love.graphics.push).was.called()
      assert.spy(love.graphics.translate).was.called.with(5, 5)
      assert.spy(love.graphics.pop).was.called()
    end)


    it("translates the children to where the content starts", function()
      local b = Node({ margin = 5, padding = 4 })
      drawing.standard(b)

      assert.spy(love.graphics.translate).was.called.with(9, 9)
    end)

    it("draws an image if available", function()
      spy.on(drawing, "image")
      local b = Node({ image = mock_love.image })
      drawing.standard(b)
      assert.spy(drawing.image).was.called.with(b)
    end)

    it("draws a background image with the background color if provided but not rectangle", function()
      local image = mock_love.newImage()
      local b = Node({ backgroundColor = {0, 1, 1, 1 },
        backgroundImage = image,
        width = image.width,
        height = image.height
      })
      mock(love)
      drawing.standard(b)
      assert.spy(love.graphics.setColor).was.called_with(b.backgroundColor)
      assert.spy(love.graphics.rectangle).was_not_called()
      assert.spy(love.graphics.draw).was.called()
    end)

    describe("rectangle tests", function()

      it("paints a background.color for it's area if provided", function()
        local node = { padding = 4, backgroundColor = { 1, 1, 1, 1 }, width = 120, height = 483 }
        local b = Node(node)
        b:layout()

        drawing.standard(b)

        assert.spy(love.graphics.setColor).was.called_with(node.backgroundColor)
        assert.spy(love.graphics.rectangle).was.called_with("fill", 0, 0, 128, 491, 0, 0)
      end)

      it("provides rounded corners if provided", function()
        local node = { backgroundColor = {1, 1, 1, 1}, width = 120, height = 40,
          cornerRadiusX = 2, cornerRadiusY = 3 }
        local b = Node(node)
        b:layout()

        drawing.standard(b)
        assert.spy(love.graphics.rectangle).was.called.with("fill", 0, 0, 120, 40, 2, 3)
      end)
    end)

    it("can lookup the color if specified as a string", function()
      local colors = require "moonpie.graphics.colors"
      local comp = { backgroundColor = "red", width = 120, height = 483 }
      local b = Node(comp)
      b:layout()

      drawing.standard(b)
      assert.spy(love.graphics.setColor).was.called.with(colors.red)
    end)

    it("sets the opacity of the background color if specified", function()
      local comp = { backgroundColor = { 1, 1, 1, 1 }, opacity = 0.5, width = 120, height = 485 }
      local n = Node(comp)
      n:layout()
      drawing.standard(n)
      assert.spy(love.graphics.setColor).was.called.with(match.is_same({ 1, 1, 1, 0.5 }))
    end)

    describe("border", function()
      local bordered = Node{ margin = 2, border = 3, width = 20, height = 25, borderColor = { 1, 0, 1, 1 }  }
      bordered:layout()

      it("sets the line width to the border size", function()
        drawing.standard(bordered)
        assert.spy(love.graphics.setLineWidth).was.called.with(3)
      end)

      it("sets the border color", function()
        drawing.standard(bordered)
        assert.spy(love.graphics.setColor).was.called.with(bordered.borderColor)
      end)

      it("translates away the margin and half the border for line width", function()
        drawing.standard(bordered)
        assert.spy(love.graphics.translate).was.called.with(3.5, 3.5)
      end)

      it("draws a rectangle for the border minus border to account for the line-width", function()
        drawing.standard(bordered)
        local w, h = bordered.box.borderPosition.width, bordered.box.borderPosition.height
        assert.spy(love.graphics.rectangle).was.called.with("line", 0, 0, w - 3, h - 3, 0, 0)
      end)

      it("can lookup the color if specified as a string", function()
        local colors = require "moonpie.graphics.colors"
        local comp = { borderColor = "red", border = 2, width = 120, height = 483 }
        local b = Node(comp)
        b:layout()
        drawing.standard(b)
        assert.spy(love.graphics.setColor).was.called.with(colors.red)
      end)

      it("provides rounded corners if provided", function()
        local node = { border = 1, borderColor = {1, 1, 1, 1}, width = 120, height = 40,
          cornerRadiusX = 2, cornerRadiusY = 3 }
        local b = Node(node)
        b:layout()
        drawing.standard(b)
        assert.spy(love.graphics.rectangle).was.called.with("line", 0, 0, 121, 41, 2, 3)
      end)
    end)
  end)

  describe("Image", function()
    local image = mock_love.newImage()
    before_each(function()
      local c = { image = image, width = 100, height = 100, color = { 1, 1, 0, 1 } }
      local node = Node(c)
      node:layout()
      drawing.image(node)
    end)

    it("does nothing if there is no image", function()
      local node = Node({})
      drawing.image(node)
      assert.spy(love.graphics.draw).was_not.called.with(nil, 0, 0)
    end)

    it("pushes to the translation stack", function()
      assert.spy(love.graphics.push).was.called()
    end)

    it("pops the translation stack", function()
      assert.spy(love.graphics.pop).was.called()
    end)

    it("moves to the content position", function()
      assert.spy(love.graphics.translate).was.called.with(0, 0)
    end)

    it("sets the color", function()
      assert.spy(love.graphics.setColor).was.called.with({ 1, 1, 0, 1 })
    end)

    it("draws the image at the content position", function()
      assert.spy(love.graphics.draw).was.called.with(image, 0, 0, 0, 1, 1)
    end)

    it("if no color is set just use white", function()
      local c = { image = mock_love.newImage(), width = 100, height = 100 }
      local node = Node(c)
      node:layout()
      drawing.image(node)
      assert.spy(love.graphics.setColor).was.called.with({ 1, 1, 1, 1 })
    end)

    it("scales the image to the content area", function()
      local img = mock_love.newImage()
      local c = { image = img, width = 150, height = 150 }
      local node = Node(c)
      node:layout()
      drawing.image(node)
      assert.spy(love.graphics.draw).was.called.with(img, 0, 0, 0, 1.5, 1.5)
    end)
  end)

  it("will call custom drawing commands if method is available", function()
    local c = {
      drawComponent = spy.new(function() end),
      width = 100,
      height = 100
    }
    local node = Node(c)
    node:layout()
    node:paint()
    assert.spy(c.drawComponent).was.called_with(node)
  end)

  it("translates the custom content properly", function()
    local c = {
      drawComponent = spy.new(function() end),
      width = 100,
      height = 100,
      padding = 10,
      margin = 10
    }
    local node = Node(c)
    node:layout()
    drawing.customContent(node)
    assert.spy(love.graphics.translate).was.called_with(20, 20)
  end)
end)
