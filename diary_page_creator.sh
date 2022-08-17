#!/bin/bash

# Script that creates template page for a diary page for the selected month and year, in Markdown format
# Format is


INIT_DATE="09/2020"
[ $1 ] && INIT_DATE=$1

INIT_MONTH=$(echo $INIT_DATE | cut -d'/' -f1)
MONTH=$INIT_MONTH
YEAR=$(echo $INIT_DATE | cut -d'/' -f2)
DAY=01
FILE_NAME=page.md

while [[ $INIT_MONTH == $MONTH ]]
do
  case $(date -v"$MONTH"m -v"$DAY"d -v"$YEAR"y  +'%d') in
  01 | 21 | 31)
    echo -e $(date -v"$MONTH"m -v"$DAY"d -v"$YEAR"y  +'# %dst of %B %Y, %A  \n') | sed -E 's/(0)([1-9][trns])/\2/' >> $FILE_NAME
  ;;
  02 | 22)
    echo -e $(date -v"$MONTH"m -v"$DAY"d -v"$YEAR"y  +'# %dnd of %B %Y, %A  \n') | sed -E 's/(0)([1-9][trns])/\2/' >> $FILE_NAME
  ;;
  03 | 23)
    echo -e $(date -v"$MONTH"m -v"$DAY"d -v"$YEAR"y  +'# %drd of %B %Y, %A  \n') | sed -E 's/(0)([1-9][trns])/\2/' >> $FILE_NAME
  ;;
  *)
    echo -e $(date -v"$MONTH"m -v"$DAY"d -v"$YEAR"y  +'# %dth of %B %Y, %A  \n') | sed -E 's/(0)([1-9][trns])/\2/' >> $FILE_NAME
  ;;
  esac

  NEW_DATE=$(date -v"$MONTH"m -v"$DAY"d -v"$YEAR"y -v+1d +'%d/%m')
  DAY=$(echo $NEW_DATE | cut -d'/' -f1)
  MONTH=$(echo $NEW_DATE | cut -d'/' -f2)
done
