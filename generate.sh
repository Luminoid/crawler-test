#!/bin/bash

if [ $1 = "clean" ]; then
    rm source/_posts/*
fi

if [ $1 = "new" ]; then
    if [ $# -ne 2 ]; then
        echo "Error! Usage: sh generate.sh new <post_num>"
        exit 1
    fi

    cd source/_posts
    count="$(ls -1q | wc -l)"
    start=$(($count + 1))
    end=$(($start + $2 - 1))
    for i in `seq $start $end`
    do
        hexo new Title$i
        lorem-ipsum 3 paragraphs >> Title$i.md
        echo "\n<!-- more -->\n" >> Title$i.md
        lorem-ipsum 5 paragraphs >> Title$i.md
    done
    cd ../..
fi

if [ $1 = "deploy" ]; then
    if [ $# -ne 2 ]; then
        echo "Error! Usage: sh generate.sh deploy <commit_message>"
        exit 2
    fi

    commit_message=$2

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
fi
