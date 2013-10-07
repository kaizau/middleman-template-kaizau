## Stylesheets

### Code Conventions

* 2 space soft-tabs
* lower-spinal-case selectors and variables
* alphabetize properties
* `@include` and `@extend` come before properties whenever possible
* `@import`s are ordered from global to specific

### Naming Conventions

* modules and elements are top-level classes (style is independent of context)
* modules classes are single-words (`.footernav`, not `.footer-nav`)
* module sub-elements follow a `.module-element-modifier` pattern

#### Base

Global styles. Sass variables, mixins, placeholders, layout, global properties,
typography, and vertical rhythm.

#### Elements

Atomic UI elements. Can be single tags or small groups of classes (`.button`,
`.input.text input`). Can be nested within modules but not other elements.

#### Modules

High-level interface modules (`.topnav`). Can contain global elements as well
as module-specific elements. Can be nested within other modules.

#### Hacks and Experiments

Code that's temporary or experimental should be kept in `_HACKS.sass` to keep
the main stylesheets clean. This file is appended to `application.css`,
overriding everything that comes before it. Remember to thoroughly document
everything and to periodically take out the garbage.
