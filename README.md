# inst_parser
para ejecutar correr: ./TEST
para compilar correr:
	clear
	flex -l flex.l
	bison -dv bison.y 
	gcc -Wall -o TEST bison.tab.c lex.yy.c -lfl
