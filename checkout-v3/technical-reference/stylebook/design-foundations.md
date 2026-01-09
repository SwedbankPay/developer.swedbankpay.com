---
title: Design Foundations
permalink: /:path/design-foundations/
description: |
 Design Foundations
menu_order: 1000
---

# Design Foundations

Design foundations define the visual principles and design tokens used across
all components. These rules must be followed consistently to ensure visual
alignment with the checkout.

---

## Accessibility (WCAG 2.2 AA)

All UI elements comply with **WCAG 2.2 AA**.

Key requirements include:
- All functionality is operable using a keyboard only.
- A logical and predictable tab order is maintained.
- Focus indicators are always visible.
- Minimum contrast requirements are met for text and non-text UI elements.
- Color is not the only means of conveying information.
- Interactive elements meet minimum touch target size requirements.

All components and states described in this stylebook are designed to meet these
requirements.

[More information](../accessibility)

---

## Color system

Colors are defined using functional tokens rather than decorative names.

### Backgrounds
- Page background: `--Background-BG-White`
- Surface background: `--Background-BG-White`

### Text
- Default text: `--Text-Default`
- Muted text: defined in Typography

### Functional colors
- Primary action: `--Functional-Base-1`
- Borders: `--Functional-Base-4`

Color combinations must meet WCAG contrast requirements.

---

## Surfaces and layout

The checkout uses **flat surfaces**.

Visual separation is achieved using:
- Background color
- Borders
- Spacing

No elevation or drop shadow is used.

---

## Borders

Borders are used to define component boundaries and selected states.

- Default border width: `1px`
- Selected state border width: `3px`
- Border radius is defined per component

Borders must meet non-text contrast requirements (3:1).

---

## Spacing

Spacing is consistent and intentional.

- Internal spacing is defined per component
- Vertical rhythm is prioritized over decorative separation
- Excessive nesting and dense layouts should be avoided
