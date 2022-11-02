flex flex.l
bison -yd bison.y
gcc y.tab.c lex.yy.c
del lex.yy.c
del y.tab.h
del y.tab.c
start a.exe
pause

