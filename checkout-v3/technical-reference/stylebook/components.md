---
title: Components
permalink: /:path/components/
description: |
  Components
menu_order: 1600
---

# Components

Components are reusable UI building blocks used throughout the checkout.
They follow the design principles and tokens defined in the Design Foundations
and must comply with the accessibility requirements described in this stylebook.

---

## Card

Cards are used to present selectable payment methods and to group related payment
content. Each card provides a clear, tappable surface with a title, optional
description, and supporting icons.

Cards are flat and rely on background color, borders, spacing, and radius for
visual separation. No elevation or drop shadow is used.

### Usage
- Use cards to represent selectable payment methods.
- Cards should always be fully clickable.
- Avoid placing multiple primary actions inside a single card.

### Structure
A card may contain:
- Payment method icon
- Card title
- Optional description
- Expand icon (for collapsible content)

---

### Card container

**Visual properties**
- Background color: `#FFFFFF`
- Border: `1px solid #D4C4BC`
- Border radius: `16px`
- Padding: `16px`
- Internal spacing (gap): `48px`

Cards must have sufficient contrast against the surrounding background.

---

### Card title

The card title identifies the payment method and is always visible in the
collapsed state.

Card titles use **Title** as defined in
[Typography](./typography.md).

---

### Card description

The card description provides short explanatory text below the title.

Descriptions use the standard body text style defined in
[Typography](./typography.md).

Descriptions are optional but recommended for clarity.

---

### Payment method icon

Payment method icons visually identify the payment option.

- Icon height: `40px`
- Width: `auto` (maintain aspect ratio)

Icons follow the rules defined in [Icons](./icons.md) and must not be the only
means of conveying information.

---

### Expand icon

The expand icon indicates that the card can be opened to reveal additional
content.

- Width: `24px`
- Height: `24px`

The icon changes orientation when the card is expanded.
Expand/collapse must never be communicated by color alone.

Icon usage follows the rules defined in [Icons](./icons.md).

---

### Selected card state

The selected state indicates the currently active payment method.

The selected state is defined in [States](./states.md).

**Visual properties**
- Border radius: `8px`
- Border: `3px solid #2F2424`

The selected state must be clearly distinguishable and meet WCAG contrast
requirements for non-text UI components.

---

## Button

Buttons are used to trigger actions in the checkout, such as initiating payment.
Primary buttons represent the most important action on the page and are visually
prominent.

Buttons are full-width and placed at the bottom of the current context whenever
possible.

---

### Primary button (enabled)

**Visual properties**
- Height: `62px`
- Padding: `16px`
- Border radius: `8px`
- Background color: `#2F2424`
- Content alignment: `centered`
- Internal spacing (gap): `8px`

Button text must have sufficient contrast against the background.

---

### Primary button (disabled)

Disabled buttons indicate that the action is currently unavailable.

**Visual properties**
- Background color: `#EBE7E2`
- Size, padding, and radius are identical to the enabled button

Disabled buttons:
- Are not focusable
- Are not interactive
- Must not rely on color alone to communicate state

---

### Accessibility

This component is designed to comply with WCAG 2.2 AA.

- All interactive functionality is operable using a keyboard.
- Interactive elements have sufficient touch target size.
- Focus indicators are clearly visible during keyboard navigation.
- States such as selected, disabled, and error are clearly distinguishable.

For general accessibility requirements, see [Accessibility](../accessibility)