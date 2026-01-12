---
title: Accessibility Checklist
permalink: /:path/accessibility/
description: |
 Use this checklist to verify that UI implementations align with the accessibility requirements described in this stylebook.
menu_order: 1100
---

## WCAG 2.2 AA – Quick Checklist

Use this checklist to verify that user interface implementations align with the
accessibility requirements described in this stylebook.

---

### Keyboard navigation
- All functionality is operable using a keyboard only.
- Interactive elements are reachable using the keyboard (Tab key).
- Focus order follows a logical reading order.
- No keyboard traps are present.

---

### Focus and interaction
- Focus indicators are always visible.
- Focus is not removed or suppressed.
- Focus remains visible against all backgrounds.
- Hover effects are not the only indicator of interactivity.

---

### Contrast and color
- Text has a minimum contrast ratio of 4.5:1 against its background.
- Large text meets a minimum contrast ratio of 3:1.
- Non-text UI elements (borders, icons, focus indicators) have a minimum contrast ratio of 3:1.
- Color is not the only means of conveying information.

---

### Touch targets
- Interactive elements meet minimum touch target size requirements defined by WCAG.
- Small visual elements have sufficient interactive hit areas.

---

### Text and content
- All form fields have visible labels.
- Placeholder text is not used as the only label.
- Text remains readable when resized.

---

### Text resizing and scaling
- Text can be resized up to 200% without loss of content or functionality.
- Layout adapts when text is resized and does not cause content overlap or clipping.
- Text resizing does not introduce horizontal scrolling on common viewport widths.
- Relative units (such as rem) are used to support user-controlled text scaling.

---

### Icons and imagery
- Icons do not replace text for critical information.
- Decorative icons are hidden from assistive technology.
- Interactive icons are keyboard accessible and focusable.

---

### States and feedback
- Selected, disabled, and error states are clearly distinguishable.
- Error messages are communicated using text in addition to visual styling.
- Status changes are not conveyed by color alone.

---

### Consistency and predictability
- Interaction patterns are consistent across components.
- Navigation and behavior are predictable.

---

#### Want to learn more about accessibility?

[Swedbank Pay and Accessibility](https://www.swedbankpay.com/information/wcag)

[WCAG 2.2 – Quick Reference Guide](https://www.w3.org/WAI/WCAG22/quickref/)
