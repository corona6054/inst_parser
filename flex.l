%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
#ifndef yywrap
static int yywrap(void) { return 1;}
#endif
%}
DIGITO [0-9]
LETRAS [_a-zA-Z]
ID {LETRAS}({LETRAS}|{DIGITO})*
CONSTANTE {DIGITO}+
%%
"inicio" {return (INICIO);}
"fin" {return (FIN);}
":=" {return (ASIGNACION);}
";" {return (PUNTOYCOMA);}
"leer" {return (LEER);}
"(" {return (PARENIZQUIERDO);}
")" {return (PARENDERECHO);}
"escribir" {return (ESCRIBIR);}
"," {return (COMA);}
{CONSTANTE}  {
    yylval.num=atoi(yytext);
    return (CONSTANTE);
    }
"+" {return (SUMA);}
"-" {return (RESTA);}
{ID} {
    yylval.cadena=yytext;
    return (ID);
}
" "  {}
.    {printf("(ERROR LEXICO)");};
%%
