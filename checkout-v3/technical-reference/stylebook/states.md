---
title: States & Interaction
permalink: /:path/states/
description: |
  States & Interaction
menu_order: 1400
---

# States

States describe how components visually respond to interaction and context.

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

**Properties**
- Border radius: 8px
- Border: 3px solid `--Functional-Base-1`

Selected state must be clearly distinguishable without relying on color alone.

---

## Disabled

Disabled components:
- Are not interactive
- Are not focusable
- Are visually distinct but still readable

---

### Accessibility

This component is designed to comply with WCAG 2.2 AA.

- All interactive functionality is operable using a keyboard.
- Interactive elements have sufficient touch target size.
- Focus indicators are clearly visible during keyboard navigation.
- States such as selected, disabled, and error are clearly distinguishable.

For general accessibility requirements, see [Accessability](../accessibility)