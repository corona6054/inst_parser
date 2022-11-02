%{
    /*         Consigna:
    
    Hacer un programa utilizando flex y bison que realice analisis léxico,
    sintáctico y semántico de micro.
    Deben personalizar los errores e implementar al menos 3 rutinas semánticas.

sumar: CONSTANTE|
           sumar SUMA sumar {mostrarResultado($1+$3);}
;

    */ 
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include <string.h>

extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);
void mostrarResultado(char*);
%}
%union {char* cadena; int num;}
%token INICIO FIN ID ASIGNACION PUNTOYCOMA LEER PARENIZQUIERDO PARENDERECHO ESCRIBIR COMA CONSTANTE SUMA RESTA
%left SUMA RESTA
%type <cadena> ID  
%type <num> CONSTANTE 
%%
programa: INICIO ID FIN {mostrarResultado($2);}
; 
%%
int main()
{
yyparse();
}
void mostrarResultado(char* a)
{
    printf("%s",a);
    int getc();
}
void yyerror(char* mensaje){
 printf("mi error era: %s",mensaje); 

}

int yyrap()
{	
return 1;
}
