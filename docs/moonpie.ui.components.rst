moonpie.ui.components
=====================

Components represent any kind of control or ui element. They are designed
similar to React components. Each component should handle a specific demand 
on the UI. These components should be nested and reused as appropriate.

Default components are defined for very commonly used elements, but you
should plan on extending the components with ones specific for your game.

For example, a possible hierarchy of components on a title screen:

* Title screen

  * Background Animation
  * Title
  * Menu

    * Button (New Game)
    * Button (Resume)
    * Button (Quit)

Defining Components
^^^^^^^^^^^^^^^^^^^

Components are defined by calling the components initializer and passing a name
for the component and a function block that returns a table to represent a new
instance of the component.

.. code-block:: lua

  local components = require "moonpie.ui.components"
  local widget = components("widget", function(props)
    return {
      -- Properties can be defined on the component
      styles = "custom-style",
      width = "75%",

      -- This nests a child component within this component
      components.h1 { text = "Heading" },
      components.text { text = "Hello World!" },
    }
  end)

  moonpie.render("ui", widget()) -- sets the UI to render this component


Component Methods
^^^^^^^^^^^^^^^^^

These are methods that can be used or overridden to provide additional
behavior for the UI

draw_component(self)
  A method for executing custom drawing commands. Love will already be configured
  to translate to the appropriate x/y coordinates on the screen so all drawing
  commands should be assumed to start based on the top-left of the content area
  for the component.

remove
  Flags the component to be removed from the render tree.



Component Properties
^^^^^^^^^^^^^^^^^^^^

logger
  Easy access to the logger library