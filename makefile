default:
	clear
	flex -l lex.l
	bison -dv bison.y 
	gcc -o test bison.tab.c lex.yy.c -lfl