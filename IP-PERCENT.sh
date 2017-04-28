#!/bin/bash
filename="/var/log/accel-ppp/IP2"
declare -a NAMES
declare -a NUM
declare -a D_NAMES	# Discrete pool names
declare -a D_NUM	# Discrete pool count

echo "AAAA"

mycount1=0
mycount2=1
dcount=0

while read line;

do
	name="$line"
	tokens=$(echo $name | tr "=" "\n")

#	echo "$name"

	for token in $tokens
	do
	   echo "$mycount1"
	   echo "$mycount2"
	   if [ $mycount2 -eq 1 ]
	   then
		NAMES[$mycount1]=$token
		mycount2=$[mycount2+1]
	   

	   elif [ $mycount2 -eq 2 ]
	   then
                NUM[$mycount1]=$token
		count2=1
		mycount1=$[mycount1+1]
		mycount2=$[mycount2-1]
	   fi
	   
	done
	

##	while count<${#name}
	##	ch=${name:count:count+1}
	##	echo $count
	##	count=$count+1


done < "$filename"

echo ${NAMES[*]}

echo " -- - - - - - - /n"

echo ${NUM[*]}

echo ${#NAMES[@]}

for ((i=0; i < ${#NAMES[@]}; i++))
do
	
#	echo "$dcount"
	if [ ${NAMES[i]} == "-" ]
	then
#		echo "  - - - - - Machted"
		continue
	fi

	D_NUM[$dcount]=25
        D_NAMES[$dcount]=${NAMES[$i]}
	echo ${D_NUM[*]}
	echo ${D_NAMES[*]}

	for((j=i+1; j < ${#NAMES[@]}; j++))
	do
		tempstr=${D_NAMES[$dcount]}
		tempstr2=${NAMES[$j]}
#		echo "------------------"
#		echo "$tempstr"
#		echo "$tempstr2"
#		echo "------------------"
		if [ $tempstr == $tempstr2 ]
		then
			temp=${D_NUM[$dcount]}
			temp2=${NUM[$j]}
			echo "$temp"
#			echo "$temp2"
			echo "Place "
			echo "$[temp+temp2]"
			echo "$dcount"
			D_NUM[$dcount]=$[temp+temp2]
			NAMES[$j]="-"
			NUM[$j]=0
		fi
	done
	dcount=$[dcount+1]
	echo " = = = = = =One exec complete = = = = = = "
#	echo "$dcount"
#	echo ${D_NUM[*]}
#	echo ${D_NAMES[*]}

done

#echo ${D_NUM[*]}

echo "********** Distinct Names *************"

echo ${D_NAMES[*]}
file="/var/log/accel-ppp/IP0"

echo "" > $file
for((j=0; j < ${#D_NAMES[@]}; j++))
do
	echo "${D_NAMES[$j]}" >> $file
	echo "${D_NUM[$j]}" >> $file 
done
echo ${D_NUM[*]}
#for name in ${NAMES[*]}

#if [ "$x" == "valid" ]; then
#  echo "x has the value 'valid'"
#fi

