#!/bin/bash

if [ $1 = "clean" ]; then
    rm source/_posts/*
fi

if [ $1 = "new" ]; then
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


