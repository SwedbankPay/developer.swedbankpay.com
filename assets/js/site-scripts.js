// Ensure DOM is ready before manipulating it
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initCookieConsent);
} else {
  initCookieConsent();
}

function initCookieConsent() {
  if (location.host === "developer.swedbankpay.com") {
    var script = document.createElement('script');
    script.src = 'https://cdn.consentmanager.net/delivery/js/semiautomatic.min.js';
    script.type = "text/javascript";
    script.setAttribute("data-cmp-ab", "1");
    script.setAttribute("data-cmp-host", "d.delivery.consentmanager.net");
    script.setAttribute("data-cmp-cdn", "cdn.consentmanager.net");
    script.setAttribute("data-cmp-cdid", "4da9d0f9328c3");
    script.setAttribute("data-cmp-codesrc", "0");
    document.body.appendChild(script);
  }
}

// Clarity script - do not change
(function (c, l, a, r, i, t, y) {
  c[a] = c[a] || function () { (c[a].q = c[a].q || []).push(arguments) };
  t = l.createElement(r); t.async = 1; t.src = "https://www.clarity.ms/tag/" + i;
  y = l.getElementsByTagName(r)[0]; y.parentNode.insertBefore(t, y);
})(window, document, "clarity", "script", "jd3awxna38");
// End of Clarity script

function updateConsent(e, o) {
  var clarityVendorId = "s2631";
  var result = __cmp('getCMPData');
  if ("vendorConsents" in result) {
    if (clarityVendorId in result.vendorConsents && result.vendorConsents[clarityVendorId]) {
      window.clarity("consentv2", { analytics_Storage: "granted" });
    } else {
      window.clarity("consentv2", { analytics_Storage: "denied" });
    }
  }
}

function initCMP() {
  if (typeof __cmp !== 'undefined') {
    __cmp("addEventListener", ["consent", updateConsent, false], null);
  } else {
    setTimeout(initCMP, 100);
  }
}

initCMP();
