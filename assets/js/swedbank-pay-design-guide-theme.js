// Initialize Mermaid.js
(function() {
    mermaid.initialize({
        startOnLoad: true,
        securityLevel: 'loose',
        htmlLabels: true,
        sequence: {
            useMaxWidth: false,
            width: 300
        },
        flowchart: {
            useMaxWidth: false
        }
    });

    mermaid.init(undefined, 'code.language-mermaid');
})();

// Initialize sidebar navigation scroll activation
(function() {
    var headings = document.querySelectorAll("h2");
    var tocLinks = document.querySelectorAll("nav.doc-toc ul li a");

    var getPosition = function(el) {
      if (el) {
        var bodyRect = document.body.getBoundingClientRect();
        var elemRect = el.getBoundingClientRect();

        return elemRect.top - bodyRect.top;
      }

      return null;
    };

    window.addEventListener("scroll", function() {
        var buffer = document.body.clientHeight * 0.1;
        var currentPos = window.pageYOffset + buffer;

        // TODO: Probably a stupid way to compute "how far left can we scroll until
        //       we reach the bottom of the page", but it seems to work.
        var scrollDistanceFromBottom = document.documentElement.scrollHeight
                                     - document.documentElement.scrollTop
                                     - document.body.clientHeight
                                     - buffer;

        if (scrollDistanceFromBottom <= 0) {
            for (var link of tocLinks) {
                link.parentElement.classList.remove("active");
            }

            tocLinks[tocLinks.length - 1].parentElement.classList.add("active");
            return;
        }

        for (var i = 0; i < headings.length; i++) {
            var heading = headings[i];
            var headingPos = getPosition(heading);
            var nextHeadingPos = getPosition(headings[i + 1]);

            if (currentPos > headingPos && currentPos < nextHeadingPos) {
                for (var link of tocLinks) {
                  link.parentElement.classList.remove("active");
                }

                tocLinks[i].parentElement.classList.add("active");
                return;
            }
        }
    });
})();

// Initialize Tipue search
(function() {
    $(document).ready(function() {
        $('#tipue_search_input').tipuesearch();
    });
})();
