#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Error! Usage: sh deploy.sh <commit_message>"
    exit 1
fi

commit_message=$1

echo "$ hexo clean"
hexo clean --config source/_data/next.yml

echo "$ hexo generate & deploy"
hexo d -g --config source/_data/next.yml

echo "$ git add"
git add -A

echo "$ git commit"
git commit -m "$commit_message"

echo "$ git push"
git push
