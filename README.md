![Read the Docs](https://img.shields.io/readthedocs/moonpie)
[![Build Status](https://travis-ci.org/tredfern/moonpie.svg?branch=master)](https://travis-ci.org/tredfern/moonpie)
[![Coverage Status](https://coveralls.io/repos/github/tredfern/moonpie/badge.svg?branch=master)](https://coveralls.io/github/tredfern/moonpie?branch=master)
[![LOVE](https://img.shields.io/badge/L%C3%96VE-11.2-EA316E.svg)](http://love2d.org/)

# moonpie
Framework for Game Development in Love2D

## Motivation
I love working with [Love2d](http://love2d.org). I like that there was limited structure that allows for 
different approaches to developing the code. I like that it feels focused on providing a foundation without
an overly rigid structure.

And, whenever I work in it, I wanted a structure that worked for me. And that is where Moonpie evolved from.
Primarily it is focused around providing an approach to GUI that is _responsive_ and easy to craft user experiences.
As the UI matured I found I needed to bring more and more pieces together. Those pieces have evolved into this
framework.

## UI Components

UI components are reusable blocks of code that represent the controls on the screen. 

```
moonpie = require "moonpie"
moonpie.ui.components("fancy_title", function(props)
  return {
    moonpie.ui.components.h1({ text = props.title_text }),
    moonpie.ui.components.hr()
  }

end)

moonpie.render("ui", moonpie.ui.components.fancy_title({ title_text = "Hello World" }))
```

## Rendering

Rendering is performed by traversing the tree and then rendering, if appropriate:
 1. The element's background
 1. The element's border
 1. The element's children
 1. The element's image

## Components

Components are the reusable bits of logic. All the controls are based on components. The idea is to compose
more complex components by combining the features of more simple ones. Components are defined by creating
functions that define the behavior to return the appropriate table element to represent a new version of that
component.

## Keyboard

Moonpie supports adding hotkeys that can trigger callbacks.

```
  moonpie.keyboard:hotkey("escape", function() ... end)
```

## Challenges / Changes / Ideas / Todo

 1. Reduce the amount of work by using canvases to handle elements that are not changing
 1. Every index lookup into a node is recomputing the styles and then returning the key. 
  This is because each update the style could have changed (mouse hover for example). But
  within a frame it should not. Precomputing styles could reduce burden of the engine.
 1. Should be able to remove a component completely from the render tree.

## Goals
 * 100% Unit Test Coverage
 * Game framework that allows rapid development
 * Easy to adjust layout as needed
 * Layout without specifying every pixel
 * Layout is dynamic to different screen sizes
 * Handling user input is intuitive and testable

## Demo
![Demo](screenshots/moonpie_progress.gif)

## Acknowledgments 
### Game Icons
The entire game icons library has been imported into this project. I attempted to do this in a way that will allow
it to be easily updated and maintained. Please visit game-icons.net for the complete information about this 
fantastic project. Specific license for the icons is located in the moonpie/assets/icons folder.

All icons are created by the following authors:
- Lorc, http://lorcblog.blogspot.com
- Delapouite, https://delapouite.com
- John Colburn, http://ninmunanmu.com
- Felbrigg, http://blackdogofdoom.blogspot.co.uk
- John Redman, http://www.uniquedicetowers.com
- Carl Olsen, https://twitter.com/unstoppableCarl
- Sbed, http://opengameart.org/content/95-game-icons
- PriorBlue
- Willdabeast, http://wjbstories.blogspot.com
- Viscious Speed, http://viscious-speed.deviantart.com - CC0
- Lord Berandas, http://berandas.deviantart.com
- Irongamer, http://ecesisllc.wix.com/home
- HeavenlyDog, http://www.gnomosygoblins.blogspot.com
- Lucas
- Faithtoken, http://fungustoken.deviantart.com
- Skoll
- Andy Meneely, http://www.se.rit.edu/~andy/
- Cathelineau
- Kier Heyl
- Aussiesim
- Sparker, http://citizenparker.com
- Zeromancer - CC0
- Rihlsul
- Quoting
- Guard13007, https://guard13007.com
- DarkZaitzev, http://darkzaitzev.deviantart.com
- SpencerDub
- GeneralAce135
- Zajkonur
- Catsu
- Starseeker
- Pepijn Poolman
- Pierre Leducq
