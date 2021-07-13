---
title: Home
---
# Types

  - [SwedbankPaySDK](SwedbankPaySDK):
    Class defining data types exposed to the client app using the SDK
  - [SwedbankPaySDKController](SwedbankPaySDKController):
    Swedbank Pay SDK ViewController, initialize this to start the payment process
  - [SwedbankPaySDK.MerchantBackend](SwedbankPaySDK_MerchantBackend):
    Additional utilities supported by the Merchant Backend
  - [SwedbankPaySDK.MerchantBackendError](SwedbankPaySDK_MerchantBackendError):
    Ways that the SwedbankPaySDK.MerchantBackendConfiguration
    can fail
  - [SwedbankPaySDK.Problem](SwedbankPaySDK_Problem):
    Base class for any problems encountered in the payment.
  - [SwedbankPaySDK.ClientProblem](SwedbankPaySDK_ClientProblem):
    A `ClientProblem` always implies a HTTP status in 400-499.
  - [SwedbankPaySDK.ClientProblem.MobileSDKProblem](SwedbankPaySDK_ClientProblem_MobileSDKProblem)
  - [SwedbankPaySDK.ClientProblem.SwedbankPayProblem](SwedbankPaySDK_ClientProblem_SwedbankPayProblem)
  - [SwedbankPaySDK.PaymentMenuRedirectPolicy](SwedbankPaySDK_PaymentMenuRedirectPolicy):
    Possible ways of handling a payment menu redirect
  - [SwedbankPaySDK.Language](SwedbankPaySDK_Language)
  - [SwedbankPaySDK.ConsumerOperation](SwedbankPaySDK_ConsumerOperation)
  - [SwedbankPaySDK.PaymentOrderOperation](SwedbankPaySDK_PaymentOrderOperation):
    Type of operation the payment order performs
  - [SwedbankPaySDK.ItemType](SwedbankPaySDK_ItemType)
  - [SwedbankPaySDK.DeliveryTimeFrameIndicator](SwedbankPaySDK_DeliveryTimeFrameIndicator):
    Product delivery timeframe for a `SwedbankPaySDK.RiskIndicator`.
  - [SwedbankPaySDK.PreOrderPurchaseIndicator](SwedbankPaySDK_PreOrderPurchaseIndicator):
    Pre-order purchase indicator values for `SwedbankPaySDK.RiskIndicator`
  - [SwedbankPaySDK.ReOrderPurchaseIndicator](SwedbankPaySDK_ReOrderPurchaseIndicator):
    Re-order purchase indicator values for `SwedbankPaySDK.RiskIndicator`
  - [SwedbankPaySDK.ShipIndicator](SwedbankPaySDK_ShipIndicator):
    Shipping method for `SwedbankPaySDK.RiskIndicator`
  - [SwedbankPaySDK.ShipIndicator.Raw](SwedbankPaySDK_ShipIndicator_Raw)
  - [SwedbankPaySDK.ServerProblem](SwedbankPaySDK_ServerProblem):
    Any unexpected response where the HTTP status is outside 400-499 results in a `ServerProblem`; usually it means the status was in 500-599.
  - [SwedbankPaySDK.ServerProblem.MobileSDKProblem](SwedbankPaySDK_ServerProblem_MobileSDKProblem)
  - [SwedbankPaySDK.ServerProblem.SwedbankPayProblem](SwedbankPaySDK_ServerProblem_SwedbankPayProblem)
  - [SwedbankPaySDK.WebViewRedirect](SwedbankPaySDK_WebViewRedirect)
  - [SwedbankPaySDKController.WebContentError](SwedbankPaySDKController_WebContentError):
    Ways that the payment can fail after the configuration
    has successfully started it.
  - [SwedbankPaySDKController.WebRedirectBehavior](SwedbankPaySDKController_WebRedirectBehavior)
  - [SwedbankPaySDK.MerchantBackendConfiguration](SwedbankPaySDK_MerchantBackendConfiguration):
    A SwedbankPaySDKConfiguration for integrating with a backend
    implementing the Merchant Backend API.
  - [SwedbankPaySDK.Operation](SwedbankPaySDK_Operation):
    Swedbank Pay Operation. Operations are invoked by making an HTTP request.
  - [SwedbankPaySDK.PayerOwnedPaymentTokens](SwedbankPaySDK_PayerOwnedPaymentTokens):
    Payload of PayerOwnedPaymentTokensResponse
  - [SwedbankPaySDK.PayerOwnedPaymentTokensResponse](SwedbankPaySDK_PayerOwnedPaymentTokensResponse):
    Response to MerchantBackend.getPayerOwnedPaymentTokens
  - [SwedbankPaySDK.PaymentTokenInfo](SwedbankPaySDK_PaymentTokenInfo):
    Information about a payment token
  - [SwedbankPaySDK.PaymentTokenInfo.MobileSDK](SwedbankPaySDK_PaymentTokenInfo_MobileSDK)
  - [SwedbankPaySDK.SimpleRequestDecorator](SwedbankPaySDK_SimpleRequestDecorator)
  - [SwedbankPaySDK.Consumer](SwedbankPaySDK_Consumer):
    Consumer object for Swedbank Pay SDK
  - [SwedbankPaySDK.Instrument](SwedbankPaySDK_Instrument):
    Payment instrument for an Instrument mode payment order.
  - [SwedbankPaySDK.PaymentOrder](SwedbankPaySDK_PaymentOrder):
    Description of a payment order to be created
  - [SwedbankPaySDK.PaymentOrderUrls](SwedbankPaySDK_PaymentOrderUrls):
    A set of URLs relevant to a payment order.
  - [SwedbankPaySDK.PayeeInfo](SwedbankPaySDK_PayeeInfo):
    Information about the payee (recipient) of a payment order
  - [SwedbankPaySDK.PaymentOrderPayer](SwedbankPaySDK_PaymentOrderPayer):
    Information about the payer of a payment order
  - [SwedbankPaySDK.OrderItem](SwedbankPaySDK_OrderItem):
    An item being paid for, part of a `PaymentOrder`.
  - [SwedbankPaySDK.RiskIndicator](SwedbankPaySDK_RiskIndicator):
    Optional information to reduce the risk factor of a payment.
  - [SwedbankPaySDK.PickUpAddress](SwedbankPaySDK_PickUpAddress):
    Pick-up address data for `SwedbankPaySDK.RiskIndicator`
  - [SwedbankPaySDK.PinPublicKeys](SwedbankPaySDK_PinPublicKeys):
    Object for certificate pinning with public keys found in app bundle certificates
  - [SwedbankPaySDK.SwedbankPaySubProblem](SwedbankPaySDK_SwedbankPaySubProblem):
    Object detailing the reason for a `SwedbankPayProblem`.
  - [SwedbankPaySDK.TerminalFailure](SwedbankPaySDK_TerminalFailure)
  - [SwedbankPaySDK.ViewConsumerIdentificationInfo](SwedbankPaySDK_ViewConsumerIdentificationInfo):
    Data required to show the checkin view.
  - [SwedbankPaySDK.ViewPaymentOrderInfo](SwedbankPaySDK_ViewPaymentOrderInfo):
    Data required to show the payment menu.
  - [SwedbankPaySDK.WhitelistedDomain](SwedbankPaySDK_WhitelistedDomain):
    Whitelisted domains

# Protocols

  - [SwedbankPaySDKRequestDecorator](SwedbankPaySDKRequestDecorator)
  - [SwedbankPaySDKRequest](SwedbankPaySDKRequest):
    A handle to a request started by a call to SwedbankPaySDKConfiguration.
  - [SwedbankPaySDKConfiguration](SwedbankPaySDKConfiguration):
    A SwedbankPaySDKConfiguration is responsible for
    creating and manipulating Consumer Identification Sessions
    and Payment Orders as required by the SwedbankPaySDKController.
  - [SwedbankPaySDKConfigurationWithCallbackScheme](SwedbankPaySDKConfigurationWithCallbackScheme):
    A refinement of SwedbankPaySDKConfiguration.
    SwedbankPaySDKConfigurationWithCallbackScheme uses knowledge of the
    custom scheme used for `paymentUrl` to only accept
    `paymentUrl` with the original scheme or the specified scheme.
  - [SwedbankPaySDKDelegate](SwedbankPaySDKDelegate):
    Swedbank Pay SDK protocol, conform to this to get the result of the payment process

# Extensions

  - [Request](Request)
