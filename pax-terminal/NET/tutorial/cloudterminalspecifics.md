---
title: Cloud Terminal Specifics
description: |
    The only difference, implementation wise, from a LAN connection is a call to DoPairing method.
permalink: /:path/cloudterminalspecifics/
menu_order: 67
---
The only extra call that is needed when using a cloud connected terminal compared to a LAN connected, is the call for pairing the terminal with the POS. The pairing is done once per terminal and POS. [Setup of credentials][credentialsetup] must have been done prior to the call, but may be done during installation of the POS. A successful pairing results in an obtained channel id which is stored encrypted in a configuration file in the same directory as the SDK (SwpTrmLib.dll). You may do pairing several times, but the obtained channel id is valid until next pairing is done, so once is enough.

The method is a member of the ISwpTrmIf_1 interface.

 Method signature: **Task<bool> DoPairingAsync(string pairingCode);**

{:.code-view-header}
**Note that call to DoPairing is done after call to Start**

```c#
    Start(new SaleApplInfo() {
        ProviderIdentification = "The best",
        SoftwareVersion = "1.0",
        ApplicationName = "A Demo",
        POIID = POIID,
        CloudConnectionType = CloudConnectionTypes.CLOUD
    });

    if (await DoPairing(pairingcode)) {

        //Pairing successful. Proceed with call to Open
    }
```

[credentialsetup]: /pax-terminal/NET/tutorial/cloudsetup
