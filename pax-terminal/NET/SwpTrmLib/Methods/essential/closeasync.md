---
title: Close
permalink: /:path/closeasync/
description: |
    This method sends a LogoutRequest to terminate the login session and allow for maintenance.
menu_order: 90
---
### Method Signatures

*   void Close(bool MaintenanceAllowed = true)

*   async Task CloseAsync(bool MaintenanceAllowed = true)

### Description

The Close/CloseAsync method sends a LogoutRequest to terminate the login session and allow for maintenance. Call this method at least once every day to ensure that parameter updates are possible.
Use the `MaintenanceAllowed` flag to ensure the terminal will not update. This is typically used during business hours.
