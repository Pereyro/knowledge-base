#!/bin/bash
#######################################################
host="`hostname`";
time="`date "+%H:%M:%S"`"
date="`date "+%Y-%m-%d"`"
#######################################################
logname="${date}_${host}_memory_monitor.csv"
basedir=/home/user/memory_monitor
#######################################################
max_map_count=$( cat /proc/sys/vm/max_map_count )
balloon="`vmware-toolbox-cmd stat balloon`"
####################################################### CREATE LOG DIRECTORY IF IT's NOT EXISTS #########################
if [ -d "$basedir"/logs ]; then
	echo "otlichno";
else
	mkdir $basedir;	
fi
#######################

#######################
if [ -d "$basedir"/logs ]; then
	if [ -e "$basedir"/logs/"$logname" ] ; then
		ps -Ao pid,rss,vsz,%mem,%cpu,cmd --sort=-%mem | head -n 6 | awk -v var="$date" -v var2="$time" -v var3=$max_map_count -v var5=$balloon 'BEGIN{OFS="|"} \
		{if (NR > 1) {"wc -l < /proc/"$1"/maps" | getline var4; close("wc -l < /proc/"$1"/maps"); print NR-1,var,var2,$1,$2=int($2/1024),$3=int($3/1024),$4,$5,$6,var3,var4,var5}}' >> "$basedir"/logs/"$logname";
	else
		echo "DATE|TIME|PID|RSS|VSZ|MEM|CPU|MAXMAPCOUNT|MAPS|BALLOON" >> "$basedir"/logs/"$logname";
		ps -Ao pid,rss,vsz,%mem,%cpu,cmd --sort=-%mem | head -n 6 | awk -v var="$date" -v var2="$time" -v var3=$max_map_count -v var5=$balloon 'BEGIN{OFS="|"} \
		{if (NR > 1) {"wc -l < /proc/"$1"/maps" | getline var4; close("wc -l < /proc/"$1"/maps"); print NR-1,var,var2,$1,$2=int($2/1024),$3=int($3/1024),$4,$5,$6,var3,var4,var5}}' >> "$basedir"/logs/"$logname";
	fi
fi
