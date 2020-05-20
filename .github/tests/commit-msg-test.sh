#!/bin/bash

original_branch_name=$(git rev-parse --abbrev-ref HEAD)

touch commit-msg.txt

# Positive tests
git checkout -B feature/DX-723 --no-track --quiet
echo "DX-723: Some commit message" > commit-msg.txt
.githooks/commit-msg commit-msg.txt
test $? -eq 0 || echo "Feature branch not supported (capital case)"

git checkout -B hotfix/DX-723 --no-track --quiet
echo "DX-723: Some commit message" > commit-msg.txt
.githooks/commit-msg commit-msg.txt
test $? -eq 0 || echo "Hotfix branch not supported (capital case)"

git checkout -B bugfix/DX-723 --no-track --quiet
printf "DX-723: Some commit message" > commit-msg.txt
.githooks/commit-msg commit-msg.txt
test $? -eq 0 || echo "Bugfix branch not supported (capital case)"

git checkout -B release/1.2.3 --no-track --quiet
printf "1.2.3: Some commit message" > commit-msg.txt
.githooks/commit-msg commit-msg.txt
test $? -eq 0 || echo "Release branch not supported (capital case)"

git checkout -B feature/dx-723 --no-track --quiet
printf "dx-723: Some commit message" > commit-msg.txt
.githooks/commit-msg commit-msg.txt
test $? -eq 0 || echo "Feature branch not supported (lower case)"

git checkout -B hotfix/dx-723 --no-track --quiet
printf "dx-723: Some commit message" > commit-msg.txt
.githooks/commit-msg commit-msg.txt
test $? -eq 0 || echo "Hotfix branch not supported (lower case)"

git checkout -B bugfix/dx-723 --no-track --quiet
printf "dx-723: Some commit message" > commit-msg.txt
.githooks/commit-msg commit-msg.txt
test $? -eq 0 || echo "Bugfix branch not supported (lower case)"

#Negative tests
git checkout -B feature/DX-123 --no-track --quiet
printf "dx-123: Some commit message" > commit-msg.txt
.githooks/commit-msg commit-msg.txt
$? -ne 0 || echo "Case prefix check failed"

git checkout -B feature/DX-123 --no-track --quiet
printf "DX-234: Some commit message" > commit-msg.txt
.githooks/commit-msg commit-msg.txt
$? -ne 0 || echo "Case number check failed"

git checkout -B "$original_branch_name"

echo "All tests good"
