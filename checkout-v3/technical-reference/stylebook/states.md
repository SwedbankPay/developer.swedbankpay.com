---
title: States & Interaction
permalink: /:path/states/
description: |
  How components visually respond to interaction and context.
menu_order: 3500
---

# States

States describe how components visually respond to interaction and context.
These states apply consistently across all interactive components unless
otherwise specified.

---

## Default

The resting state of a component.

---

## Hover

Hover is used as a supplementary cue and must not be the only indicator of
interactivity.

---

## Focus

Focus indicators are always visible and clearly distinguishable.

- Focus is shown using outlines or borders
- Focus meets WCAG contrast requirements
- Focus is not removed or suppressed

---

## Selected

The selected state indicates the active option.

It is visually emphasized to clearly distinguish it from unselected options. The
visual treatment may vary depending on component type (for example border,
background, or icon changes).

Selected states must be clearly distinguishable without relying on color alone.

Specific visual implementations are defined in the relevant component and form
field sections.

---

## Disabled

Disabled components:
- Are not interactive
- Are not focusable
- Are visually distinct, but still readable

A disabled state is communicated using reduced visual emphasis. The exact visual
treatment depends on the component type (for example muted background, border,
or text styling).

Specific visual implementations are defined in the relevant component and form
field sections.

---

## Success

The success state indicates that an action or input has been completed
successfully.

Success is communicated using visual cues such as borders or icons and must not
rely on color alone.

Specific implementations of success states are defined in the relevant component
and form field sections.

---

## Error

The error state indicates that user input or an action requires correction.

Error states are clearly distinguishable and communicated using multiple cues,
such as visual styling and explanatory text. Error indication must not rely on
color alone.

Specific implementations of error states are defined in the relevant component
and form field sections.

---

### Accessibility

These states are designed to comply with WCAG 2.2 AA.

- All interactive functionality is operable using a keyboard.
- Interactive elements have sufficient touch target size.
- Focus indicators are clearly visible during keyboard navigation.
- States such as selected, disabled, and error are clearly distinguishable.

For general accessibility requirements, see [Design Foundations](../design-foundations)
