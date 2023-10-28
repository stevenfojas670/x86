#------------------------------------
# CS 218 - Assignment #7
#  Debugger Input Script
#------------------------------------
echo \n\n
break last
run
set pagination off
set logging file a7out.txt
set logging overwrite
set logging enable on
set prompt
echo ------------------------------------ \n
echo display variables \n
echo \n
x/200dw &lst
echo \n
x/dw &len
echo \n
x/dw &min
x/dw &med
x/dw &max
x/dw &sum
x/dw &avg
echo \n \n
set logging enable off

