## Render Engine
There are 3 key things that need to operate optimally for this framework to be successful

Currently, the model is very much centralize all the information and loop through all
the nodes regularly. Instead it would be better for their to be an eventing/messaging system
that allows the nodes and render engine to work together.


- Currently, we search through every node for updates... what if instead we queued all updates to
  be processed?


### Layout
Computing the layout needs to be efficient. 

1. It should quickly calculate the positions of elements.
2. It should be able to avoid unnecessary layout calculations
3. It should create a layout that is expected everytime

### Painting/Drawing/Rendering
Painting the UI is a constant demand. Optimizing this one will be the most difficult.
Generally the painting sequence for each node is:
1. Background
2. Children
3. My content

Usually most of the content for a node that has a hierarchy should be it's children...

### Updating

Components need to update and change data regularly. Any game should have updating stats and values that
will trigger some changes to the system. This could result in whole areas of the tree rerendering, which
can trigger a brand new node to be created. Avoiding unnecessary node refreshes should be key.

- State system introduced should avoid some of the unnecessary creation/deletion because
  we can update values directly
1. Updating should trigger only enough refreshing that things work
