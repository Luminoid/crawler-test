#!/bin/bash

if [ $1 = "clean" ]; then
    rm source/_posts/*
fi

if [ $1 = "new" ]; then
    count="$(ls -1q source/_posts | wc -l)"
    start=$(($count + 1))
    end=$(($start + $2 - 1))
    for i in `seq $start $end`
    do
        hexo new Title$i
        lorem-ipsum 5 paragraphs >> source/_posts/Title$i.md
    done
fi


