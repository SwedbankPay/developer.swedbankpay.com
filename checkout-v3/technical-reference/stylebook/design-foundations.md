---
title: Design Foundations
permalink: /:path/design-foundations/
description: |
 Design foundations define the visual principles and design tokens used across all components. 
menu_order: 1000
---

# Design Foundations

Design foundations describe functional roles and design principles rather than
component-specific implementations.

How colors, spacing, borders, and other tokens are applied to individual UI
components is defined in the relevant **component** and **form field** sections.

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
- Text can be resized up to 200% without loss of content or functionality.
- Layout adapts to text resizing without causing content clipping or horizontal scrolling.

All components and states described in this stylebook are designed to meet these
requirements.

[Accessibility Checklist](../accessibility)

---

## Color system

### Backgrounds
- Page background: `#FFFFFF`
- Surface background: `#FFFFFF`

### Text
- Default text: `#2F2424`
- Muted text: `#72605E`

### Functional colors
- Primary action: `#2F2424`
- Borders: `#A38B80`

### Status colors
- Success: `#31A3AE`
- Error: `#D82E2A`

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
