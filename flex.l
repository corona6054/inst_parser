%{
	#include<stdio.h>
	#include<stdlib.h>
                #include "y.tab.h"
#ifndef yywrap
static int yywrap(void) { return 1;}
#endif
%}
DIGITO [0-9]
LETRAS [a-zA-Z]
IDENTIFICADOR {LETRAS}({LETRAS}|{DIGITO})*
%%
{DIGITO}+  {yylval.num=atoi(yytext);return (CONSTANTE);};
{IDENTIFICADOR} {return (ID);}
"+" {return (MAS);}
.     {printf("ES UN ERROR LEXICO");};
%%
