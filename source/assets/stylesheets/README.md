## Stylesheets

### Code Conventions

**General**

* Soft-tabs, 2 spaces
* Lower-spinal-case selectors and variables
* Alphabetized properties
* `@include` and `@extend` come before properties whenever possible
* `@import`s ordered from general to specific

**Class Names**

* General to specific, left to right (`.header`, `.header-tagline`, `.header-tagline_special`)
* Underscores for modifier classes (`.button_danger`)
* Modules and elements are top-level classes (unaffected by the cascade)
* Modules classes are single-words (`.footernav` not `.footer-nav`)

**Variable Names**

* 2-stage color variables: value (`$gray-dark: #444`) and usage (`$color-heading: $gray-dark`)
* Variables should start with their property when possible (`$border-radius-alert`)

### Folder Structure

* **Base**
  - Global styles, variables, mixins, etc.
* **Elements**
  - Atomic UI elements
  - Single tags or small groups of classes (`.button`, `.input.text input`)
  - Cannot contain other elements or modules
* **Modules**
  - High-level interface groups (`.topnav`)
  - Typically contain a group of elements
  - Can have elements or other modules nested within
* **Hacks / Experiments**
  - Quarantine for temporary or experimental code
  - Use liberally and clean out periodically
* **Vendor**
  - 3rd party code
  - Never edit these files directly
