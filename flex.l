%{
#include <stdio.h>
#include <stdlib.h>
#include "bison.tab.h"
#ifndef yywrap
static int yywrap(void) { return 1;}
  extern int line_num;
#endif
#define YYSTYPE char*

%}
DIGITO [0-9]
LETRAS [_a-zA-Z]
ID {LETRAS}({LETRAS}|{DIGITO})*
CONSTANTE {DIGITO}+
%%
"F_READ" {return (F_READ);}
"F_WRITE" {return (F_WRITE);}
"SET" {return (SET);}
"MOV_IN" {return (MOV_IN);}
"MOV_OUT" {return (MOV_OUT);}
"F_TRUNCATE" {return (F_TRUNCATE);}
"F_SEEK" {return (F_SEEK);}
"CREATE_SEGMENT" {return (CREATE_SEGMENT);}
"I/O" {return (IO);}
"WAIT" {return (WAIT);}
"SIGNAL" {return (SIGNAL);}
"F_OPEN" {return (F_OPEN);}
"F_CLOSE" {return (F_CLOSE);}
"DELETE_SEGMENT" {return (DELETE_SEGMENT);}
"EXIT" {return (EXIT);}
"YIELD" {return (YIELD);}
"\n" { line_num++; return (NEWLINE);  }
{CONSTANTE}  {
    yylval.num=atoi(yytext);
    return (CONSTANTE);
    }
{ID} {
        strcpy(yylval.cadena,yytext);
    return (ID);
}
" "  {}
.    {printf("(ERROR LEXICO)");};
%%
