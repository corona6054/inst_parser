%{
    /*         Consigna:
    
    Hacer un programa utilizando flex y bison que realice analisis léxico,
    sintáctico y semántico de micro.
    Deben personalizar los errores e implementar al menos 3 rutinas semánticas.

    */ 
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);
void mostrarResultado(int);
%}
%union {char* cadena; int num;}
%token CONSTANTE MAS
%token <cadena>  ID
%left MAS
%type <num> sumar CONSTANTE 
%%
sumar: CONSTANTE|
           sumar MAS sumar {mostrarResultado($1+$3);}
;
%%
int main(){
yyparse();
}
void mostrarResultado(int a){
    printf("%d",a);
    int getc();
}
void yyerror(char* mensaje){
 printf("mi error era: %s",mensaje); 

}
int yyrap()
{	
return 1;
}
