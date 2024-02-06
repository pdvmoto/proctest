#!/bin/ksh 

#
# testing procstat, loop over the -o options..
#

# always just show version and help

procstat -V

procstat -h 

list of
optformat=" sar-u sar-u sar-u-ALL cpu-all mpstat-P-ALL \
  per-cpu-all sar-d sar-b sar-B sar-H sar-S iostat iostat-x \
  sar-r sar-r-ALL sar-n-DEV \
  sar-n-EDEV sar-q-LOAD sar-q sar-q-CPU sar-q-IO sar-q-MEM sar-W sar-w \
  vmstat "


maxsec=30
optu=' -u 30 ' 
opthist=''
optread=''
optweb=' -w '
optport=' -P 1111 '
optarch=''
optarchi=''
optheader=' -n10 ' 

for outfmt in $optformat 
do

  echo .
  procstatcmd=` \
    echo timeout $maxsec procstat \
    $optu \
    $optweb \
    $optheader \
    -o $outfmt `

  echo testing :  $procstatcmd

  $procstatcmd
 
  echo .
  echo done option $opt

done


# more options later

exit
