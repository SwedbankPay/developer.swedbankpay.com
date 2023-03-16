---
title: AbortAsync
---

The AbortRequestAsync method will send an AbortRequest for the last issued request to the terminal. The Abort message itself, is not responded to by the terminal but the actual request being aborted is.

{% include alert.html type="warning" icon="warning" header="warning"
body="The result from AbortAsync will always have ResponseResult failure as of now"
%}
