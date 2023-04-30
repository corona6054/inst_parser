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
void asignarVar(char var[32], int num, int num2);

%}
%union {char* cadena; int num;}
%token F_READ F_WRITE SET MOV_IN MOV_OUT F_TRUNCATE F_SEEK CREATE_SEGMENT IO WAIT SIGNAL F_OPEN F_CLOSE DELETE_SEGMENT EXIT YIELD ID CONSTANTE
%type <cadena> ID  
%type <num> CONSTANTE
%%
programa:  listasentencia EXIT {mostrarResultado("Intruccion correcta /n");}
;
listasentencia: sentencias 
;
sentencias: F_READ CONSTANTE CONSTANTE { asignarVar("ALGO:",$2,$3); contadorVar++;     printf("parametros asignada: %d \n",listaIds[contadorVar].valor2);
}
;

%%
int main()
{
        yyparse();
}


void asignarVar(char var[32], int num, int num2)
{
    int fintexto=0;
        for (int i = 0; i <32; i++)
        {
            if(var[i]==':'||var[i]==' ') i=33; else fintexto++;

        }
        char texto[32];
        strncpy(texto,&var[0],fintexto);

    listaIds[contadorVar].valor = num;
        listaIds[contadorVar].valor2 = num2;

    strcpy(listaIds[contadorVar].nombre,texto);

    printf("parametros asignada: %d \n",listaIds[contadorVar].valor);
    printf("parametros asignada: %d \n",listaIds[contadorVar].valor2);
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
