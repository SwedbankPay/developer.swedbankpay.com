function OptanonWrapper() { }

function activateClarity() {
    // Clarity script - do not change
    (function(c,l,a,r,i,t,y){
        c[a]=c[a]||function(){(c[a].q=c[a].q||[]).push(arguments)};
        t=l.createElement(r);t.async=1;t.src="https://www.clarity.ms/tag/"+i;
        y=l.getElementsByTagName(r)[0];y.parentNode.insertBefore(t,y);
    })(window, document, "clarity", "script", "jd3awxna38");
    // End of Clarity script
}

function getCookie(name) {
    if (document.cookie.split(";").some((c) => c.trim().startsWith(name + "="))) {
      return document.cookie.split(";").find((c) => c.trim().startsWith(name + "="));
    }
    else {
      return false;
    }
}

function deleteCookie(name) {
    if (getCookie(name)) {
        document.cookie = name + "=;domain=.swedbankpay.com;path=/;expires=Thu, 01 Jan 1970 00:00:01 GMT";
    }
}

function inactivateClarityCookies() {
    deleteCookie("_clck");
    deleteCookie("_clsk");
}

window.addEventListener("DOMContentLoaded", (event) => {
  if (location.host === "developer.swedbankpay.com") {
    var script = document.createElement('script');
    script.src = 'https://cdn.cookielaw.org/scripttemplates/otSDKStub.js';
    script.type = "text/javascript";
    script.charset = "UTF-8";
    script.setAttribute("data-domain-script", "77c777e5-115a-4e3d-81ec-cc857a4ac846");
    document.body.appendChild(script);
  }
  else {
    document.cookie = "_clck=;domain=.swedbankpay.com;expires=Thu, 01 Jan 1970 00:00:01 GMT";
    document.cookie = "_clsk=;domain=.swedbankpay.com;expires=Thu, 01 Jan 1970 00:00:01 GMT";
  }  
});

window.addEventListener("OneTrustGroupsUpdated", (event) => {
    if (event.detail && event.detail.indexOf("C0002") !== -1) {
      activateClarity();
    }
    else {
      inactivateClarityCookies();
    }
});
