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

addStyle(self, style)
  Adds a new style tag to the component.

drawComponent(self)
  A method for executing custom drawing commands. Love will already be configured
  to translate to the appropriate x/y coordinates on the screen so all drawing
  commands should be assumed to start based on the top-left of the content area
  for the component.

findByID(self, id)
  Searches the component's child hierarchy to find the first matching identifier.

.. code-block:: lua

  local found = component:findByID("sampleComponentID")

hide(self)
  Marks a component as hidden and removes from layout and rendering

isHidden(self)
  Returns true if a component is marked as hidden.

mounted(self)
  A method that is called when a component has been added to the render tree. Layout
  and other information will not be calculated at this point but the node should be
  aware of its place in the render tree.

remove(self)
  Flags the component to be removed from the render tree.

removeStyle(self, style)
  Removes a style tag from the component.

show(self)
  Marks a component as visible and will show up in layouts and rendering.

unmounted(self)
  A method called when a component is destroyed from the render tree. Used for any
  kind of global cleanup necessary when the component is removed that would be difficult
  for the garbage collector to know about. For example, global event handlers or lambdas.

Component Properties
^^^^^^^^^^^^^^^^^^^^

data
  This can be used to pass in customized initialization data that will be stored in the component. 

.. code-block:: lua

  local c = Components.h1 { data = { a = "a", b = 3 } }
  print(c.data.a) -- "a"
  print(c.data.b) -- 3

logger
  Easy access to the logger library

Component Events
^^^^^^^^^^^^^^^^

onUpdate(component, changes)
  Called whenever the component receives an update call.

.. code-block:: lua

  local callbackRoutine = function(component, changes) print(changes.newValue) end
  local c = component { onUpdate = callbackRoutine }
  c:update({ newValue = "foo" }) 
  -- prints "foo"

onMouseMove(component, x, y)
  Called whenever the mouse moves around over the component. `x`, `y` are screen coordinates

moonpie.ui.styles
~~~~~~~~~~~~~~~~~

Styles are a way of setting common properties that are easy to change across the site. These work similar
to CSS in HTML though without the full selector behavior. Styles are applied directly to an element.
When calculating values some properties do inherit from the parent to make it easier to specify items like
fonts to be defaulted through.

Style Properties
----------------

display [inline, inline-block, block]
  Describes how the component should calculate its width. The main ones to use our ``inline`` and ``block``.
  ``block`` is the default display setting, this will expand the component to the maximum width available. Determined
  by the parent. ``inline`` will size the component based on the width of the children.

textwrap
  specifies that whether text should wrap. Default behavior if nil is to wrap text. If set to 'none' will disable wrapping

Default Styles
~~~~~~~~~~~~~~

Buttons
-------

button-small
  Makes a smaller button for those tinier button needs

button-primary
  A style that uses the primary color for the background of the button

button-warning
  A style that uses a gold/yellow background color

button-danger
  A style that uses a red/fuschia background color


Built In Components
~~~~~~~~~~~~~~~~~~~

body
~~~~

The *body* component defaults to a full screen component that uses the *background* color by default. This will
create a clean empty background for the rest of the components to render upon. The only custom parameter takes
the contents to render.

Properties
----------

contents
  A table that will be rendered out within the body

**Example**

.. code-block:: lua

  local Components = require "moonpie.ui.components"

  local body = Components.body {
    content = {
      -- custom screen elements
    }
  }

image
~~~~~

Properties
----------

source
  The path to the image to be loaded


textbox
~~~~~~~

Methods
-------

getText(self)
  Returns the text currently in the text box

setText(self, value, skipUpdateCursor)
  Sets the text within the textbox to the specific value. By default, the cursor will move to the end of the string,
  passing true to skipUpdateCursor will bypass this.

