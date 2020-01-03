#!/bin/sh

 wget http://pear.php.net/go-pear.phar

echo suhosin.executor.include.whitelist = phar >>/etc/php/7.0/cli/conf.d/suhosin.ini 

   php go-pear.phar
    for mod in $*
     do
     mod=`echo $mod | sed "/[;&]/s///g"`
     pear install $mod
     done
   rm go-pear.phar
  
