[![Build Status](https://travis-ci.org/tredfern/moonpie.svg?branch=master)](https://travis-ci.org/tredfern/moonpie)
[![Coverage Status](https://coveralls.io/repos/github/tredfern/moonpie/badge.svg?branch=master)](https://coveralls.io/github/tredfern/moonpie?branch=master)
[![LOVE](https://img.shields.io/badge/L%C3%96VE-11.2-EA316E.svg)](http://love2d.org/)

# moonpie
Dynamic Layout UI Library with Tests

## Motivation

After reviewing some other GUI libraries out there for Love2D, I realized I should not write another one. 
Sadly, I could not resist. After thinking about how browsers and libraries like React and others
work with UI/UX, I thought that maybe there was an opportunity to design something like that for Love2d.

I loved the idea in immediate mode UI's that state causes problems. But I couldn't overcome building a UI 
out of conditionals. I did some reading on how browsers work and it just sounded kind of cool.

I have a project that I'd like to apply this library to in order to see whether it actually will work. In
the meantime, I'm building it up with the foundational function that I think it will need to support before
I can use it.

## Basic Design Ideas

I tried to break apart rendering, layout, and event logic. I wanted to make it easy for unit testing of
the UI. I didn't want there to be a burden mocking entities. I also wanted to avoid trying to convert
Lua into an OOP language. Functions and Tables should provide the core functionality needed. There is
a Component system to allow better reuse of common functionality.

## Layouts

Layouts are defined by nested tables. Think of a plain table as representing a DIV tag with no styles.
This allows common elements to be grouped together easily.

Width and height can be specified to the element to set it's area, but best is to be like HTML and define
sizes sparingly. Text elements will calculate their size based on the amount of text and the max width available.
Images will scale to specified sizes.

The outcome is that each element defined in the layout becomes a node in the layout tree. Style information
is merged into the style tree to provide reusable properties that should be consistent. Properties specified
directly onto the table will override style properties. If the element is a reusable Component, then it will
also include style information that matches the Component name. A few parent element properties are inherited
as well.

## Rendering

Rendering is performed by traversing the tree and then rendering, if appropriate:
 1. The element background
 1. The element border
 1. The elements children
 1. The elements image

## Components

Components are the reusable bits of logic. All the controls are based on components. The idea is to compose
more complex components by combining the features of more simple ones. Components are defined by creating
functions that define the behavior to return the appropriate table element to represent a new version of that
component.

## Challenges / Changes / Ideas

 1. Nothing should be considered proven until dynamic elements are included in the engine
  ( An FPS counter is the proof of concept engine needed for dynamic displays. )
 1. Reduce the amount of work by using canvases to handle elements that are not changing
 1. Allow the rebuilding of only a section of the component tree. For example, just rendering out a new inventory screen
   without necessarily rerendering the whole UI when an item is sold.

## Goals
 * 100% Unit Test Coverage
 * Easy to adjust layout as needed
 * Layout without specifying every pixel
 * Layout is dynamic to different screen sizes
 * Handling user input is intuitive and testable

## Demo
![Demo](screenshots/moonpie_progress.gif)
