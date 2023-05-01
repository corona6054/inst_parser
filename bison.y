%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include <string.h>


struct tablaVars
{
    int valor;
        int valor2;

    char nombre[32];
};
struct tablaVars listaIds[10];
int contadorVar=0;

extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);

void mostrarResultado(char* salida);
void asignarVar(int var, int num, int num2);

%}
%union {char* cadena; int num;}
%token F_READ F_WRITE SET MOV_IN MOV_OUT F_TRUNCATE F_SEEK CREATE_SEGMENT IO WAIT SIGNAL F_OPEN F_CLOSE DELETE_SEGMENT EXIT YIELD NEWLINE
%token ID CONSTANTE
%type <cadena> ID  
%type <num> CONSTANTE
%%
programa:  listasentencia EXIT {mostrarResultado("Intruccion correcta /n");}
;
listasentencia: sentencias | listasentencia sentencias
;
sentencias: sentencia1 | sentencia2
;
sentencia1: F_READ  CONSTANTE CONSTANTE NEWLINE { asignarVar(F_READ -258,$2,$3); contadorVar++;} 
;
sentencia2: F_WRITE  CONSTANTE CONSTANTE NEWLINE { asignarVar(F_WRITE-258,$2,$3); contadorVar++;}
;

%%
int main()
{
        yyparse();
    printf("parametros asignada: %d \n",listaIds[0].valor);
        printf("parametros asignada: %d \n",listaIds[1].valor);
 int num;
    scanf("%d",&num);


}


void asignarVar(int var, int num, int num2)
{


    listaIds[contadorVar].valor = num;
        listaIds[contadorVar].valor2 = num2;

    printf("parametros asignada: %d \n",var);
    printf("parametros asignada: %d \n",listaIds[contadorVar].valor);
    printf("parametros asignada: %d \n",listaIds[contadorVar].valor2);


}

void mostrarResultado(char* salida)
{
    printf("%s",salida);
    int getc();
}

void yyerror(char* mensaje){
 printf("%s",mensaje); 

}

int yyrap()
{	
return 1;
}
