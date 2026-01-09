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

Key requirements:
- Text contrast: minimum 4.5:1
- Non-text UI elements (borders, icons, focus indicators): minimum 3:1
- Focus indicators are always visible
- Color is never the only means of conveying information
- Interactive elements meet minimum touch target size

All components and states described in this stylebook are designed to meet these
requirements.

[More information](https://www.swedbankpay.com/information/wcag)

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
