---
title: DoPairingAsync
permalink: /:path/dopairing/
description: |
    The DoPairing method is used once per terminal and POS for a cloud connection.
menu_order: 17
---
### Method Signature

*   Task<bool> DoPairingAsync(string pairingcode)

### Description

The DoPairing method is used to get a channel id for connecting a specific terminal. The pairing code is shown on the terminal display when selecting pairing mode from its menu. `Start` method must be called prior to this method. Returns true if successful.

Please see [tutorial][tutor] for more information about cloud connected terminal.

[tutor]: /pax-terminal/NET/tutorial/
