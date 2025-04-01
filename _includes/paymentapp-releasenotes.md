
## About the Swedbank Pay Payment App Running On The Terminal

## Pax Release 1.3.0.7.1 (11.03.2025)

PAX-4007 Make sure the KSN used for the Online-PIN block is incremented when needed.

## Pax Release 1.3.0.7 (04.03.2025)

PAX-3996 'Graceful abort' from ECR now work as intended again.

PAX-3995 Solved an issue causing a ConcurrentModificationException being triggered.

PAX-3979 Improved acquire-card and authorise flow for plugin-app.

PAX-3977 Implemented required flag in android 10 for sending "move to foreground" intent

PAX-3967 Fixed application randomly restarting when trying to display the 'Present Card' fragment.

PAX-3966 Improved text when asking for second card.

PAX-3957 Change encoding of special characters in the receipts provided to ECRs on nexo-Retailer.

PAX-3953 Modified how an external app is started from the payment app. An External app will now not be started
right after installation, but first when the payment app is done initializing and when ready on the
initialized screen.

PAX-3946 Improved initial ECR setup by removing redundant Save-buttons, resetting input on cancellation and
overwriting entire port input field.

PAX-3944 Improved APM refund input field

PAX-3943 Fixed issues triggered by changing the orientation of the app.

PAX-3942 Fixed bug where amount was not displayed on APM refund receipt.

PAX-3937 Implemented a more informative installation prosess of external apps. More accurate fail reasons will
now be sent to TMS on failure.

PAX-3908 Merchant verification is limited to terminals in ECR mode 'standalone'.

PAX-3905 Plugin cancel reason is now added to payment-response

PAX-3904 Functionality to change idle background color for branding purposes.

PAX-3843 Improved cancellation handling for QR-payment

PAX-3842 The terminal will now increment the KSN on new authorization attempt(s) after a SCA response(s)

PAX-3840 Fixed 'Print Response' from the Terminal, so that it always conforms with the nexo-retailer XSD schema

PAX-3411 Added Norwegian, Swedish, Finnish and Danish translations for menu items

## Pax Release 1.3.0.6.1 (13.02.2025)

PAX-3918 Fixed an issue with using ECR on device with Intent on Android 10

## Pax Release 1.3.0.6 (04.02.2025)

PAX-3932 Terminal will no longer trigger 'Application Selection' when using the YELLOW key, when the
configured Country Code is not Norway or Denmark

PAX-3910 The terminal will now respect the TMS configuration set for 'Preferred application' for AID
A0000001214712 (previously this specific AID was always being set to 'preferred')

PAX-3899 When both the Terminal and Card support BankAxept, BankAxept will always be selected for 'Purchase
with Cashback' transactions.

PAX-3895 We now add terminal type 9F35 to icc data

PAX-3894 Only start business apps once after boot up.

PAX-3892 Fixed issue with no message sent after cancel when running terminal with ECR on device.

PAX-3886 Improve behavior when aborting Application Selection

PAX-3871 Fixed a bug where the application would get stuck if card was removed during application selection on
Card Acquisition

PAX-3850 Display MAC address on 'System info'

PAX-3849 'Application Selection' for Chip/Contact now works properly on the next transaction, after being
aborted.

PAX-3848 The Terminal will now properly reverse transactions in scenarios where the terminal first has gotten a
SCA response from host and then need to authorize again after PIN-entry (or Chip+PIN). Relevant for
nexo-Acquirer (not SPDH).

PAX-3845 Added fallback indicator to plugin app message.

PAX-3837 Fixed an issue that caused tip not to included after canceling an APM transaction

PAX-3833 Payment app will start business applications when boot has completed, instead of as part of its
initialisation process

PAX-3830 Network check flow on initializing terminal updated with new flow and design

PAX-3827 Implemented new functionality for opening ECR on device. Including app name in menu and check if the
app is already opened or not.

PAX-3811 Decision screens updated to new design

PAX-3780 Removed option to export logs to local folder on terminal

PAX-3779 Delete old, exported logs from the terminal. In order to free up space on the disk.

## Pax Release 1.3.0.5.1 (12.12.2024)

PAX-3833 Payment app will start business applications when boot has completed, instead of as part of its
initialisation process

## Pax Release 1.3.0.5 (03.12.2024)

PAX-3847 Improved clearing of sent TMS events

PAX-3828 Implemented the ability to control the max allowed tip percentage of total amount that can be added on
custom tip amount screen.

PAX-3821 Switching language now works again (when only two languages available).

PAX-3807 Fixed a bug where the application would get stuck if starting a payment failed when running as
Embedded

PAX-3804 Updated design on ECR settings screen

PAX-3803 Improved payment-response handling

PAX-3800 Fixed an issue with back button text on APM screen on A30

PAX-3798 Fixed a bug where the terminal would not understand that connection to the ECR was restored after a
network breakdown at a specific point during a transaction

PAX-3792 QR code will now correctly update on new terminal port during the ECR setup stage

PAX-3785 Improved footer on error screens

PAX-3784 Improved abortrequest handling

PAX-3781 All business apps are now started on boot; not just those stopped by the OS

PAX-3778 The zipped logfile is now deleted from the Terminal after upload is complete

PAX-3772 Padding adjusted on tip info line on present card screen on A30

PAX-3771 Added ability to activate internet via USB on A35 in admin menu without first getting parameters from
TMS

PAX-3769 Fixed a bug where input fields in the ECR settings would not be saved unless explicit green button was
pressed on some terminal models

PAX-3762 Terminal will now use default receipt print settings if options is removed in TMS, on A920 without
requiring restart

PAX-3727 Implemented new system for controlling tip/extra options from TMS

PAX-3716 Added mapping for host response code 1B

PAX-3714 Design updated on present card screen

PAX-3654 Improvements in the CHIP Refund flow (As some VISA cards were previously declined locally due to
wrong conditions being checked)

PAX-3646 Design updated on tip screen

PAX-3271 Terminal is now easier to navigate using hardware buttons

## Pax Release 1.3.0.4 (29.10.2024)

PAX-3773 Improved client cancellation handling

PAX-3761 Terminal now gives option to edit terminal port on ECR setup screen

PAX-3745 The merchant receipt will no longer contain a SignatureBlock when Magstripe + PIN has been used

PAX-3741 Fixed an issue with UI scaling on some terminals

PAX-3740 Improved save button design on ECR initial setup screens

PAX-3733 Fix swedish translation for no more pin attempts

PAX-3725 Fixed an issue that certain senarios triggered multiple messages to the ECR when aborting a
transaction.

PAX-3723 Improved cardacquisition canceling

PAX-3715 Added check and option for network settings when on load terminal initialization screen

PAX-3705 Increase the 'connect timeout' from 3 to 5 seconds (on the Acquirer connection)

PAX-3704 Fixed a bug where the terminal would be stuck on Input Request after user requests Application
Selection.

PAX-3685 Minor standalone main menu icon update

PAX-3678 Will no longer prompt for ECR settings when running as Embedded

PAX-3677 Minor design update to admin menu

PAX-3671 Design update on menu buttons

PAX-3670 Design updated on transaction outcome loader

PAX-3669 Design update on warning screens

PAX-3657 Fixed an issue causing buttons on screen to behave incorrectly when prompted to insert card.

PAX-3655 Fixed a visual error in the language menu on some screens

PAX-3617 Added support for 'Amount Based Application Selection'

PAX-3456 Added more information and options on terminal activation screen

PAX-3125 Cashback is not allowed when using magstripe

PAX-1381 Will notify ECR through display request when terminal cannot update config due to offline transactions
