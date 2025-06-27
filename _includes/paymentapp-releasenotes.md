
## 26 June 2025

### Pax Release 1.3.0.10

PAX-4119 Can now receive loyalty accounts from host

PAX-4117 Can now requets and receive cloud logs via intents

PAX-4099 Fixed an issue causing footer logo to behave unexpected on start of transaction on screen change

PAX-4098 Added pairing option in cashier menu when using cloud connect.

PAX-4097 Fixed an issue preventing the transaction outcome loader animation from animating outcome

PAX-4075 Fixed a bug where the terminal could end up using a wrong CVM method for EMV cashback transactions

PAX-4062 Terminal now support ecr cloud communication

## 6 June 2025

### Pax Release 1.3.0.9

PAX-4091 Improve selectable profile start up check

PAX-4089 A small fix to set APM error to false so we not showing the error text if we retry a APM payment after getting internet.

PAX-4088 Improved initialising flow in terminal start up.

PAX-4083 Set a 30 second callTimeout in the acquirer-client. To make sure the terminal does not hang more than 30 seconds waiting for a  response during poor network conditions (where the existing connect and read timeouts doesn't trigger).

PAX-4066 Terminal will now retry to send apm cancel message every 2 minutes

PAX-4064 Admin menu item 'Switch ECR mode' is now hidden when terminal is configured with an unselectable ECR profile.

PAX-4047 'Purchase with cashback' is now (by default) hidden on Standalone terminals. Merchants that wants to
support 'Purchase with cashback' must use the Admin-menu to make it visible.

PAX-4041 Ignore Client Only ECRs trying to abort transactions when it is not allowed (or using Wrong Service ID or Device ID when trying to abort something). (Instead of trying to send them a notification they cannot receive)

PAX-4038 Added serial number to system info

PAX-4019 For simplification in the setup of new terminals, improvements has been implemented to when and how the setup screens for admin password, manager password and merchant verification are triggered.

PAX-4018 Blind mode is implemented and available from the localization menu. After activation it will be on until one transaction is complete. The screens in the payment process will have speech, and own pin pad for blind on terminals with on screen pin pad.

PAX-4014 Fix localization of 'Internet via USB' admin-menu option

PAX-3221 Implemented new branding system

## 14 April 2025

### Pax Release 1.3.0.8

PAX-4042 Improved application update implementation

PAX-4032 Application now handles Apm problem event correctly

PAX-4015 Added more possible APK installation failure reasons

PAX-4011 Solved an issue where amounts from previous transaction was visible on tip screen.

PAX-4004 When running ECR on Device mode the footer menu will now be available on please wait screen.

PAX-4002 Fixed issues with multiple software downloads

PAX-4001 Remove POI-ID field from ECR Settings on the A920Pro. Never meant to be used.

PAX-3993 Update Installer - Allowing it to retry launching the Payment Application.
Also: Provide some debug info on bottom of display, if something fails prematurely in the Installer, in order to provide information to us on what/where stuff actually fails, so that we can try to fix that later.
Note: The Installer provided in 1.3.0.8 will not be used before upgrading or downgrading from this specific version. Meaning: It does not come into play when performing an upgrade from 1.3.0.x to 1.3.0.8.

PAX-3975 The ready screen now informs if external ECR app is not installed in ECR mode (embedded).

PAX-3973 Terminal now support selectable ecr profile

PAX-3852 Some mastercards that would be declined will now correctly fallback to chip instead.

PAX-3838 A default APN will now be automatically created on terminals with a 'Swedbank Pay' flavored SIM-card
installed.
Requires:

*   Mobile Network Enabled
*   No APN previously configured
*   ICCID of SIM-Card recognized

## 11 March 2025

### Pax Release 1.3.0.7.1

PAX-4007 Make sure the KSN used for the Online-PIN block is incremented when
needed.

## 4 March 2025

### Pax Release 1.3.0.7

PAX-3996 'Graceful abort' from ECR now work as intended again.

PAX-3995 Solved an issue causing a ConcurrentModificationException being
triggered.

PAX-3979 Improved acquire-card and authorise flow for plugin-app.

PAX-3977 Implemented required flag in android 10 for sending "move to
foreground" intent.

PAX-3967 Fixed application randomly restarting when trying to display the
'Present Card' fragment.

PAX-3966 Improved text when asking for second card.

PAX-3957 Change encoding of special characters in the receipts provided to ECRs
on nexo-Retailer.

PAX-3953 Modified how an external app is started from the payment app. An
External app will now not be started right after installation, but first when
the payment app is done initializing and when ready on the initialized screen.

PAX-3946 Improved initial ECR setup by removing redundant Save-buttons,
resetting input on cancellation and overwriting entire port input field.

PAX-3944 Improved APM refund input field.

PAX-3943 Fixed issues triggered by changing the orientation of the app.

PAX-3942 Fixed bug where amount was not displayed on APM refund receipt.

PAX-3937 Implemented a more informative installation prosess of external apps.
More accurate fail reasons will now be sent to TMS on failure.

PAX-3908 Merchant verification is limited to terminals in ECR mode 'standalone'.

PAX-3905 Plugin cancel reason is now added to payment-response.

PAX-3904 Functionality to change idle background color for branding purposes.

PAX-3843 Improved cancellation handling for QR-payment.

PAX-3842 The terminal will now increment the KSN on new authorization attempt(s)
after a SCA response(s).

PAX-3840 Fixed 'Print Response' from the Terminal, so that it always conforms
with the nexo-retailer XSD schema.

PAX-3411 Added Norwegian, Swedish, Finnish and Danish translations for menu
items.

## 13 February 2025

### Pax Release 1.3.0.6.1

PAX-3918 Fixed an issue with using ECR on device with Intent on Android 10.

## 4 February 2025

### Pax Release 1.3.0.6

PAX-3932 Terminal will no longer trigger 'Application Selection' when using the
YELLOW key, when the configured Country Code is not Norway or Denmark.

PAX-3910 The terminal will now respect the TMS configuration set for 'Preferred
application' for AID A0000001214712 (previously this specific AID was always
being set to 'preferred').

PAX-3899 When both the Terminal and Card support BankAxept, BankAxept will
always be selected for 'Purchase with Cashback' transactions.

PAX-3895 We now add terminal type 9F35 to icc data.

PAX-3894 Only start business apps once after boot up.

PAX-3892 Fixed issue with no message sent after cancel when running terminal
with ECR on device.

PAX-3886 Improve behavior when aborting Application Selection

PAX-3871 Fixed a bug where the application would get stuck if card was removed
during application selection on Card Acquisition.

PAX-3850 Display MAC address on 'System info'.

PAX-3849 'Application Selection' for Chip/Contact now works properly on the next
transaction, after being aborted.

PAX-3848 The Terminal will now properly reverse transactions in scenarios where
the terminal first has gotten a SCA response from host and then need to
authorize again after PIN-entry (or Chip+PIN). Relevant for nexo-Acquirer (not
SPDH).

PAX-3845 Added fallback indicator to plugin app message.

PAX-3837 Fixed an issue that caused tip not to included after canceling an APM
transaction.

PAX-3833 Payment app will start business applications when boot has completed,
instead of as part of its initialisation process.

PAX-3830 Network check flow on initializing terminal updated with new flow and
design.

PAX-3827 Implemented new functionality for opening ECR on device. Including app
name in menu and check if the app is already opened or not.

PAX-3811 Decision screens updated to new design.

PAX-3780 Removed option to export logs to local folder on terminal.

PAX-3779 Delete old, exported logs from the terminal. In order to free up space
on the disk.

## 12 December 2024

### Pax Release 1.3.0.5.1

PAX-3833 Payment app will start business applications when boot has completed,
instead of as part of its initialisation process.

## 3 December 2024

### Pax Release 1.3.0.5

PAX-3847 Improved clearing of sent TMS events.

PAX-3828 Implemented the ability to control the max allowed tip percentage of
total amount that can be added on custom tip amount screen.

PAX-3821 Switching language now works again (when only two languages available).

PAX-3807 Fixed a bug where the application would get stuck if starting a payment
failed when running as Embedded.

PAX-3804 Updated design on ECR settings screen.

PAX-3803 Improved payment-response handling.

PAX-3800 Fixed an issue with back button text on APM screen on A30.

PAX-3798 Fixed a bug where the terminal would not understand that connection to
the ECR was restored after a network breakdown at a specific point during a
transaction.

PAX-3792 QR code will now correctly update on new terminal port during the ECR
setup stage.

PAX-3785 Improved footer on error screens.

PAX-3784 Improved abortrequest handling.

PAX-3781 All business apps are now started on boot; not just those stopped by
the OS.

PAX-3778 The zipped logfile is now deleted from the Terminal after upload is
complete.

PAX-3772 Padding adjusted on tip info line on present card screen on A30.

PAX-3771 Added ability to activate internet via USB on A35 in admin menu without
first getting parameters from TMS.

PAX-3769 Fixed a bug where input fields in the ECR settings would not be saved
unless explicit green button was pressed on some terminal models.

PAX-3762 Terminal will now use default receipt print settings if options is
removed in TMS, on A920 without requiring restart.

PAX-3727 Implemented new system for controlling tip/extra options from TMS.

PAX-3716 Added mapping for host response code 1B.

PAX-3714 Design updated on present card screen.

PAX-3654 Improvements in the CHIP Refund flow (As some VISA cards were
previously declined locally due to wrong conditions being checked).

PAX-3646 Design updated on tip screen.

PAX-3271 Terminal is now easier to navigate using hardware buttons.

## 29 October 2024

### Pax Release 1.3.0.4

PAX-3773 Improved client cancellation handling.

PAX-3761 Terminal now gives option to edit terminal port on ECR setup screen.

PAX-3745 The merchant receipt will no longer contain a SignatureBlock when
Magstripe + PIN has been used.

PAX-3741 Fixed an issue with UI scaling on some terminals.

PAX-3740 Improved save button design on ECR initial setup screens.

PAX-3733 Fix swedish translation for no more pin attempts.

PAX-3725 Fixed an issue that certain senarios triggered multiple messages to the
ECR when aborting a transaction.

PAX-3723 Improved card acquisition cancelling.

PAX-3715 Added check and option for network settings when on load terminal
initialization screen.

PAX-3705 Increase the 'connect timeout' from 3 to 5 seconds (on the Acquirer
connection).

PAX-3704 Fixed a bug where the terminal would be stuck on Input Request after
user requests Application Selection.

PAX-3685 Minor standalone main menu icon update.

PAX-3678 Will no longer prompt for ECR settings when running as Embedded.

PAX-3677 Minor design update to admin menu.

PAX-3671 Design update on menu buttons.

PAX-3670 Design updated on transaction outcome loader.

PAX-3669 Design update on warning screens.

PAX-3657 Fixed an issue causing buttons on screen to behave incorrectly when
prompted to insert card.

PAX-3655 Fixed a visual error in the language menu on some screens.

PAX-3617 Added support for 'Amount Based Application Selection'.

PAX-3456 Added more information and options on terminal activation screen.

PAX-3125 Cashback is not allowed when using magstripe.

PAX-1381 Will notify ECR through display request when terminal cannot update
config due to offline transactions.
