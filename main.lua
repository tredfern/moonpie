-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
--
-- Test/Demo for Moonpie
--

local moonpie = require "moonpie"
local components = require "components"

function love.load()
  moonpie.layout(
    components.container("button-tests", {
      components.button("button1", { text = "Click Me!" })
        :on_click(function(self) self.text = "Clicked!" end),
      components.button("button1", { text = "Click Me 2!" })
        :on_click(function(self) self.text = "Clicked 2!" end)
    }),
    components.container("text-wrapper",
      {
        components["text-border"]("text1", { text = "Hello World!", color = moonpie.colors.cyan }),
        components.text("text2", { text = "And now for something completely different", color = moonpie.colors.blue }),
    }):on_hover( { background_color = moonpie.colors.light_gray }),
    components["funky-rect"]("rect1"),
    components["funky-rect2"]("rect2"),
    components.container("text-test",
    {
      components.text("long-text", { text = [[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur arcu libero, auctor ut cursus ac, tincidunt in metus. Morbi posuere felis vel sapien sagittis condimentum. In tincidunt nulla in massa consectetur, vel dignissim lacus elementum. Ut sodales, tortor in fermentum molestie, purus nisi blandit tortor, id congue urna odio egestas felis. Fusce mollis lacinia arcu, sit amet cursus erat volutpat nec. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec augue augue, suscipit interdum varius sed, efficitur vitae mi. Etiam ligula ipsum, blandit quis nulla a, malesuada facilisis diam. Integer quis consequat mauris, quis scelerisque nisi. In at ornare massa. Morbi maximus ante et egestas vulputate. Proin laoreet tellus non ipsum lobortis ornare. Phasellus a felis in urna mollis feugiat.

      Quisque maximus feugiat tortor. Vivamus ultricies sagittis magna, sit amet semper tortor imperdiet ut. Ut volutpat nec justo a sollicitudin. Aliquam id lacus sodales, dapibus dolor at, fringilla lacus. Etiam quis neque felis. Duis congue velit in quam condimentum pretium. Cras congue dignissim magna nec porttitor. Sed vitae augue luctus, bibendum elit a, scelerisque mi. Ut sit amet massa sagittis, vestibulum turpis sit amet, laoreet velit. Nullam vehicula ultricies orci, nec laoreet turpis varius et.

      Proin at ultricies dolor, vitae aliquam lectus. Morbi eu ligula magna. Nunc convallis tellus et lectus commodo, eu porttitor orci viverra. Morbi tristique nibh sit amet ipsum lacinia lobortis. Phasellus a gravida enim. In enim orci, consequat vitae diam ac, bibendum sollicitudin dolor. Integer iaculis varius suscipit. Maecenas quam eros, iaculis ac venenatis eget, auctor ac ante. Aenean id velit id lorem congue lobortis. Pellentesque semper in erat ac tempor. Cras faucibus aliquam mauris. In euismod egestas scelerisque. Cras et feugiat tellus. Aenean imperdiet libero euismod est eleifend, et porttitor metus luctus.

      Mauris et pulvinar nunc. Curabitur aliquet dui quam, non sagittis eros semper eget. In hac habitasse platea dictumst. Nullam tristique lectus eu sapien eleifend mattis. Pellentesque imperdiet leo a arcu posuere mollis. Proin consequat orci et nisl aliquam semper. Ut nisl mi, porttitor eu sodales eu, placerat at ipsum. Pellentesque sed suscipit dolor. Proin id libero sit amet elit commodo volutpat. Curabitur interdum velit eu tellus tempor, sed interdum tellus elementum. Mauris tincidunt eleifend leo nec ultricies. Nam posuere sem et hendrerit finibus. Quisque interdum sodales varius.

      Pellentesque mollis nunc fermentum, scelerisque eros et, tempus augue. Cras mi felis, aliquam vitae elit quis, dignissim eleifend sapien. Sed egestas finibus massa, ac luctus tortor rutrum eget. In egestas rhoncus sem. Vestibulum eget ultrices enim. Vivamus elementum justo aliquet, dapibus urna sed, interdum dolor. Praesent sodales ipsum non elit maximus, vitae posuere felis scelerisque. Maecenas sed tristique ex, iaculis semper nunc. Morbi et magna libero. Fusce fermentum metus felis, maximus gravida dui efficitur non. Vivamus facilisis, leo facilisis efficitur tincidunt, arcu lacus maximus arcu, nec ultrices mi ex non ante. Integer tellus quam, ornare placerat facilisis nec, aliquam eget justo. Sed eleifend eros nec neque aliquam porta.]]
    })
  })
  )
end

function love.update()
  moonpie.update()
end

function love.draw()
  moonpie.paint()
end
