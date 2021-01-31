moonpie.ui
==========

moonpie.ui.components
~~~~~~~~~~~~~~~~~~~~~

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
-------------------

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
-----------------

These are methods that can be used or overridden to provide additional
behavior for the UI

drawComponent(self)
  A method for executing custom drawing commands. Love will already be configured
  to translate to the appropriate x/y coordinates on the screen so all drawing
  commands should be assumed to start based on the top-left of the content area
  for the component.

mounted(self)
  A method that is called when a component has been added to the render tree. Layout
  and other information will not be calculated at this point but the node should be
  aware of its place in the render tree.

remove
  Flags the component to be removed from the render tree.

unmounted(self)
  A method called when a component is destroyed from the render tree. Used for any
  kind of global cleanup necessary when the component is removed that would be difficult
  for the garbage collector to know about. For example, global event handlers or lambdas.

Component Properties
^^^^^^^^^^^^^^^^^^^^

logger
  Easy access to the logger library

moonpie.ui.styles
~~~~~~~~~~~~~~~~~

Styles are a way of setting common properties that are easy to change across the site. These work similar
to CSS in HTML though without the full selector behavior. Styles are applied directly to an element.
When calculating values some properties do inherit from the parent to make it easier to specify items like
fonts to be defaulted through.

Style Properties
----------------

textwrap
: specifies that whether text should wrap. Default behavior if nil is to wrap text. If set to 'none' will disable wrapping

Default Styles
--------------

Buttons
~~~~~~~

button-small
  Makes a smaller button for those tinier button needs

button-primary
  A style that uses the primary color for the background of the button

button-warning
  A style that uses a gold/yellow background color

button-danger
  A style that uses a red/fuschia background color