#!/bin/bash

if [ -z "$1" ]; then
    echo "What do you want to make?"
else
    yasm -f bin $1.asm -l $1.lst -o $1.com
fi