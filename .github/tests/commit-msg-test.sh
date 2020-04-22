#!/bin/bash

echo $(pwd)

$(touch commit-msg.txt)

# Positive tests
$(git checkout -B feature/DX-723 --no-track --quiet)
echo "DX-723: Some commit message" > commit-msg.txt
$(.githooks/commit-msg commit-msg.txt)
test $? -eq 0 || echo "Feature branch not supported (capital case)"

$(git checkout -B hotfix/DX-723 --no-track --quiet)
echo "DX-723: Some commit message" > commit-msg.txt
$(.githooks/commit-msg commit-msg.txt)
test $? -eq 0 || echo "Hotfix branch not supported (capital case)"

$(git checkout -B bugfix/DX-723 --no-track --quiet)
echo "DX-723: Some commit message" > commit-msg.txt
$(.githooks/commit-msg commit-msg.txt)
test $? -eq 0 || echo "Bugfix branch not supported (capital case)"

$(git checkout -B release/1.2.3 --no-track --quiet)
echo "1.2.3: Some commit message" > commit-msg.txt
$(.githooks/commit-msg commit-msg.txt)
test $? -eq 0 || echo "Release branch not supported (capital case)"

$(git checkout -B feature/dx-723 --no-track --quiet)
echo "dx-723: Some commit message" > commit-msg.txt
$(.githooks/commit-msg commit-msg.txt)
test $? -eq 0 || echo "Feature branch not supported (lower case)"

$(git checkout -B hotfix/dx-723 --no-track --quiet)
echo "dx-723: Some commit message" > commit-msg.txt
$(.githooks/commit-msg commit-msg.txt)
test $? -eq 0 || echo "Hotfix branch not supported (lower case)"

$(git checkout -B bugfix/dx-723 --no-track --quiet)
echo "dx-723: Some commit message" > commit-msg.txt
$(.githooks/commit-msg commit-msg.txt)
test $? -eq 0 || echo "Bugfix branch not supported (lower case)"

#Negative tests
$(git checkout -B feature/DX-723 --no-track --quiet)
echo "DX-dsd: Some commit message" > commit-msg.txt
$(.githooks/commit-msg commit-msg.txt)
test $? -ne 0 || echo "Case number check failed"

$(git checkout -B feature/DX-723 --no-track --quiet)
echo "dx-723: Some commit message" > commit-msg.txt
$(.githooks/commit-msg commit-msg.txt)
test $? -ne 0 || echo "Casing check failed"
