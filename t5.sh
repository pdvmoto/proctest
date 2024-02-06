[root@oracle-19c-vagrant proctest]# cat t5.sh 
#!/bin/ksh 

#
# testing procstat, run yes, run dd..
#

# always just show version and help

procstat -V

procstat -h 

# run for 2min in background
echo .
echo kick a YES in the backgrond to eat 1 cpu, then use dd
nohup timeout 60 yes  > /dev/null &

# now force use of 1G, and time it
echo .
echo now forcing use of 1G
time dd if=/dev/sda of=/dev/null bs=1G iflag=fullblock 

echo .
echo first test done, press enter to continue or ControlC to stop test
read -t 60 abc

echo .
echo kick two runs of YES in the backgrond to eat 2 cpus, then use dd
nohup timeout 60 yes first  > /dev/null &
nohup timeout 60 yes second > /dev/null &

# now force use of 1G, and time it
echo .
echo now forcing use of 1G
time dd if=/dev/sda of=/dev/null bs=1G iflag=fullblock 

echo .
echo second test done.. you have 60sec to start oracle enter or control C
read -t 60 abc


echo .
echo assue oracle is consuing 1.5G of shared mem..
echo now add dd to grab 1G
time dd if=/dev/sda of=/dev/null bs=1G iflag=fullblock 

echo .
echo third test done.. end of testing..
read abc

# end test...
exit 

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
