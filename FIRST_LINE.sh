#!/bin/bash

line=$(head -n 1 "Text")

echo "$line"

sed '1d' Text > tmp.txt

rm Text
mv tmp.txt Text
#tail -n +2 $file

echo "Done"
