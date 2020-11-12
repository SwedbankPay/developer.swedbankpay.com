/*global mermaid*/
// Initialize Mermaid.js
(function () {
    var configObject = {
        startOnLoad: true,
        securityLevel: "loose",
        htmlLabels: true,
        sequence: {
            useMaxWidth: false,
            width: 300
        },
        flowchart: {
            useMaxWidth: false
        }
    };
    mermaid.initialize(configObject);

    mermaid.init(undefined, "code.language-mermaid");
})();

// Initialize sidebar navigation scroll activation
(function () {
    var headings = document.querySelectorAll(".doc-container h2");
    const activeSubgroup = document.querySelector("nav.sidebar-nav .nav-subgroup.active");
    var tocLinks = [];

    if (activeSubgroup) {
        if (activeSubgroup.querySelector(".nav-subgroup.active")) {
            tocLinks = activeSubgroup.querySelector(".nav-subgroup.active").querySelectorAll(".nav-leaf");
        } else {
            tocLinks = activeSubgroup.querySelectorAll(".nav-leaf");
        }
        
    } else {
        tocLinks = document.querySelectorAll("nav.sidebar-nav .nav-group.active .nav-leaf");
    }

    var getPosition = function (parent, el) {
        if (el) {
            var parentRect = parent.getBoundingClientRect();
            var elemRect = el.getBoundingClientRect();
            
            return elemRect.top - parentRect.top;
        }
        
        return null;
    };

    const _handleLeafScrollListener = function () {
        if (tocLinks.length > 0) {
            const activeLeaf = document.querySelector("nav.sidebar-nav .nav-leaf.active");
            const buffer = document.body.clientHeight * 0.1;
            const currentPos = window.pageYOffset + buffer;

            // TODO: Probably a stupid way to compute "how far left can we scroll until
            //       we reach the bottom of the page", but it seems to work.
            const scrollDistanceFromBottom = document.documentElement.scrollHeight
                - document.documentElement.scrollTop
                - document.body.clientHeight
                - buffer;
                
                
            activeLeaf && !activeLeaf.classList.contains("nav-subgroup-leaf") && activeLeaf.classList.remove("active");
                
                
            if (scrollDistanceFromBottom > 0) {
                const scrollNumber = [...headings].filter((heading) => getPosition(document.body, heading) <= currentPos).length - 1;

                scrollNumber >= 0 && tocLinks[parseInt(scrollNumber, 10)].classList.add("active");
            } else {
                tocLinks[tocLinks.length - 1].classList.add("active");
            }

        }
    };

    _handleLeafScrollListener();
    
    window.addEventListener("scroll", _handleLeafScrollListener);

    // Makes sidebar scroll so that the active element is in view
    const pathHash = window.location.pathname + window.location.hash;
    const sidebarNav = document.querySelector("nav.sidebar-nav");
    var activeLeaf = document.querySelector("nav.sidebar-nav .nav-leaf.active");

    if (!activeLeaf) {
        activeLeaf = [...document.querySelectorAll(`nav.sidebar-nav .nav-leaf`)]
            .filter((navLeaf) => navLeaf.querySelector(`a[href="${pathHash}"]`))[0];
    }

    if (activeLeaf) {
        sidebarNav.scrollTop = activeLeaf.offsetTop + activeLeaf.clientHeight - sidebarNav.clientHeight / 2;
    };
    
})();

// Simple sidebar functionality while dg.js is being loaded

function _handleSimpleSidebar (e) {
    const target = e.target.parentElement.parentElement;

    if (target.tagName === "LI") {
        if (target.classList.contains("active")) {
            target.classList.remove("active");
        } else {
            const sidebar = document.querySelector(".sidebar");
            const closeElement = sidebar.querySelector(`.${target.classList[0]}.active`);

            closeElement && closeElement.classList.remove("active");

            target.classList.add("active");
        }
    }
};

(function () {
    const sidebar = document.querySelector(".sidebar");

    sidebar.addEventListener("click", _handleSimpleSidebar);
})();

// Remove simple sidebar functionality when proper sidebar functionality is loaded
(function () {
    document.addEventListener("DOMContentLoaded", (e) => {
        const sidebar = document.querySelector(".sidebar");

        sidebar.removeEventListener("click", _handleSimpleSidebar);
    });
})();

// Initialize Tipue search
(function() {
    $(document).ready(function () {
        $("#tipue_search_input").tipuesearch();
    });
})();
