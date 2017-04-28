#!/bin/bash

filename="/var/log/accel-ppp/Connected-Users"

#echo "" >> $filename

declare -a CONN_USERS_COUNT
declare -a CONN_USERS_POOL

iteration=0
conn_count=0
d_iteration=0

while read line;
do
	l="$line"
	echo "$l"
	tokens=$(echo $l | tr "=" "\n")
	for token in $tokens
	do
#		temp_str=${CONN_USERS_POOL[$d_iteration]}
#		temp_orig_str=${tokens[$d_iteration]}
#		temp_int=${CONN_USERS_COUNT[$d_iteration]}
#		echo "$temp_str"
#		echo "$token"
		if [ $token == "*" ]
		then
			continue
		fi

		if [ $iteration -eq 0 ]
		then
			CONN_USERS_POOL[$d_iteration]=$token
			CONN_USERS_COUNT[$d_iteration]=1
		else
			flag=0
		
			for ((i=0;i<${#CONN_USERS_POOL[@]};i++))	
			do
				temp_str=${CONN_USERS_POOL[$i]}
				temp_int=${CONN_USERS_COUNT[$i]}
				if [ $temp_str == $token ]
				then
					CONN_USERS_COUNT[$i]=$[temp_int+1]
					tokens[$iteration]="*"
					flag=1
				fi
			done
			if [ $flag -eq 0 ]
			then
				d_iteration=$[d_iteration+1]
	                        CONN_USERS_POOL[$d_iteration]=$token
        	                CONN_USERS_COUNT[$d_iteration]=1
				echo "$token"+"$iteration"+${CONN_USERS_POOL[*]}+${CONN_USERS_COUNT[*]}

			fi
#			CONN_USERS_COUNT[$d_iteration]=$[temp_int+1]
#			tokens[$iteration]="*"
#			CONN_USERS_POOL[$d_iteration]="*"
#			for((i=0; i<echo ${#CONN_USERS_POOL[@]};i++))
#				if [  ]
#		else
#			d_iteration=$[d_iteration+1]
#			CONN_USERS_POOL[$d_iteration]=$token
 #                       CONN_USERS_COUNT[$d_iteration]=1
#			echo "D_Iteration going to change .  . . ."
		fi
	########### WHAT TO DO FOR NEW
#		echo "$token"+"$iteration"+${CONN_USERS_POOL[*]}+${CONN_USERS_COUNT[*]}
		iteration=$[iteration+1]
		
	done
#	echo "AAAA"
done < "$filename"
#echo ${tokens[*]}

echo ${CONN_USERS_POOL[*]}
echo ${CONN_USERS_COUNT[*]}
