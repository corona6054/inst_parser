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
void mostrarResultado(char* salida);
void leerID(char *yytext);
%}
%union {char* cadena; int num;}
%token FDT INICIO FIN ID ASIGNACION PUNTOYCOMA LEER PARENIZQUIERDO PARENDERECHO ESCRIBIR COMA CONSTANTE SUMA RESTA
%left SUMA RESTA ASIGNACION
%type <cadena> ID  
%type <num> CONSTANTE 
%%
programa:   INICIO listasentencia FIN {mostrarResultado("Codigo correcto");}
;
listasentencia: sentencias | listasentencia sentencias
;
sentencias: sentencia1 | sentencia2 | sentencia3
;
sentencia1:  ID ASIGNACION expresion PUNTOYCOMA
;
sentencia2:  LEER PARENIZQUIERDO listaidentificadores PARENDERECHO PUNTOYCOMA
;
sentencia3:  ESCRIBIR PARENIZQUIERDO listaexpresiones PARENDERECHO PUNTOYCOMA
;
listaidentificadores:   ID {leerID($1);}| listaidentificadores COMA ID {leerID($3);}
;
listaexpresiones:   expresion | listaexpresiones COMA expresion
;
expresion:  primaria | expresion operadoraditivo primaria
;
primaria:   ID | CONSTANTE | PARENIZQUIERDO expresion PARENDERECHO
;
operadoraditivo:    SUMA | RESTA
;
%%
int main()
{
        yyparse();
}
void leerID(char *yytext)
{
    int lenght=0;
    for (int i = 0; yytext[i] != ' '; i++) lenght++;
    char* identificador;
    strncpy(identificador,&yytext[0],lenght);
    identificador[lenght] = '\0';
    printf("Identificador : %s \n",identificador);
}
void mostrarResultado(char* salida)
{
    printf("%s",salida);
    int getc();
}
void yyerror(char* mensaje){
 printf("mi error era: %s",mensaje); 

}

int yyrap()
{	
return 1;
}
