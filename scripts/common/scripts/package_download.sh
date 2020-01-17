#!/bin/sh

dl_type=$1
shift
source_url=$1
shift
package_name=$1
shift
extraction_command=$1
shift
destination=$1
shift
path_to_extracted=$1
shift
download_options=$*
 
cd /tmp

export PACKAGE_INSTALLER_RUN=yes
source_url=`echo $source_url | sed "/[;&]/s///g"` 
package_name=`echo $package_name | sed "/[;&]/s///g"` 
extraction_command=`echo $extraction_command | sed "/[;&]/s///g"` 
package_name=`echo $package_name | sed "/[.][.]/s///g"` 
destination=`echo $destination | sed "/[.][.]/s///g"` 
path_to_extracted=`echo $path_to_extracted | sed "/[.][.][ ]/s///g"` 

 
   
echo Source URL $dl_type $source_url 
echo Extract with $extraction_command from  $package_name to $path_to_extracted 
echo Install to $destination


 if test "$dl_type" = 'git'
  then  
  	git  clone $download_options --depth 1  $source_url "./$path_to_extracted"
  elif  test -z "$extraction_command" 
  	 then
  	  wget $download_options -O $package_name $source_url
  	  path_to_extracted=$package_name 
  else
	wget $download_options -O $package_name $source_url
	  if test -z "$path_to_extracted" -o "$path_to_extracted" = './' -o "$path_to_extracted" = '/'
		then
			path_to_extracted=app
			mkdir /tmp/app
			cd /tmp/app			
			$extraction_command ../$package_name
			cd /tmp
		else
			$extraction_command $package_name
	  fi	
  fi
 
