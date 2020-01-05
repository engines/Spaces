#!/bin/sh

    for mod in $*
     do
     mod=`echo $mod | sed "/[;&]/s///g"`
    echo " " |  pecl install $mod
     done
   
 