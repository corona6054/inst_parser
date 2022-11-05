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


struct tablaVars
{
    int valor;
    char nombre[32];
};
struct tablaVars listaIds[10];
int contadorVar=0;

extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);
void mostrarNum(int salida);
void mostrarResultado(char* salida);
void leerVAR(char *yytext);
void asignarVar(int contadorVar,char* var, int num);
int devolverNum();

%}
%union {char* cadena; int num;}
%token FDT INICIO FIN ID ASIGNACION PUNTOYCOMA LEER PARENIZQUIERDO PARENDERECHO ESCRIBIR COMA CONSTANTE SUMA RESTA
%left SUMA RESTA ASIGNACION
%type <cadena> ID  
%type <num> CONSTANTE SUMA RESTA expresion primaria operadoraditivo
%%
programa:   INICIO listasentencia FIN {mostrarResultado("Codigo correcto");}
;
listasentencia: sentencias | listasentencia sentencias
;
sentencias: sentencia1 | sentencia2 | sentencia3
;
sentencia1:  ID ASIGNACION expresion PUNTOYCOMA { asignarVar(contadorVar,$1,$3); contadorVar++;  }
;
sentencia2:  LEER PARENIZQUIERDO listaidentificadores PARENDERECHO PUNTOYCOMA
;
sentencia3:  ESCRIBIR PARENIZQUIERDO listaexpresiones PARENDERECHO PUNTOYCOMA 
;
listaidentificadores :
   ID {leerVAR($1); contadorVar++;}| listaidentificadores COMA ID {leerVAR($3); contadorVar++;}
;
listaexpresiones:   expresion { mostrarNum($1);} | listaexpresiones COMA expresion { mostrarNum($3);}
;
expresion:  primaria {$$ =$1;} 
| expresion operadoraditivo primaria { if($2) $$ = $1 + $3; else $$ = $1 - $3; }
;
primaria:   ID {$$=devolverNum();} | CONSTANTE {$$ = $1;} | PARENIZQUIERDO expresion PARENDERECHO {$$ = $2;}
;
operadoraditivo:    SUMA {$$ = 1;} | RESTA {$$ = 0;}
;
%%
int main()
{
        yyparse();
}

void leerVAR(char *yytext)
{
    int lenght=0;
    for (int i = 0; yytext[i] != ' '; i++) lenght++;
    char identificador[32];
    strncpy(identificador,&yytext[0],lenght);
    identificador[lenght] = '\0';
    printf(" %s = ",identificador);
    int num;
    scanf("%d",&num);
    listaIds[contadorVar].valor = num;
    strcpy(listaIds[contadorVar].nombre,identificador);

    printf(" %s = %d \n",listaIds[contadorVar].nombre,listaIds[contadorVar].valor);

}

void asignarVar(int contadorVar,char* var, int num)
{
    listaIds[contadorVar].valor = num;
    strcpy(listaIds[contadorVar].nombre,var);

    printf(" %s = %d \n",var,listaIds[contadorVar].valor);
}

void mostrarResultado(char* salida)
{
    printf("%s",salida);
    int getc();
}
void mostrarNum(int salida)
{
    printf("Salida: %d \n",salida);
    int getc();
}
int devolverNum()
{
    char var[32];
    int cont;
      for (int i = 0; i <2; i++)
      {
        printf("Nombre var= ");
        scanf("%s",&var);
        printf("%s = ",var);
        scanf("%d",&cont);
        printf("%s = %d \n",var,cont);
        listaIds[i].valor = cont;
        strcpy(listaIds[i].nombre,var);
      }


        for (int i = 0; i <2; i++) printf("Variable N%d:  %s = %d \n",i,listaIds[i].nombre,listaIds[i].valor);


        printf(" Buscar = ");
        scanf("%s", var);

        int fintexto=0;
        for (int i = 0; i <32; i++)
        {
            if(var[i]==32) i=10; else fintexto++;

        }
        char texto[32];
        strncpy(texto,&var[0],fintexto);

        int comparacion=0;
        int lenght=0;
        for (int i = 0; i <2; i++)
        {
            comparacion= strcmp(listaIds[lenght].nombre,texto);
            if(comparacion==0) i=10; else lenght++;

        }

        printf(" %s = %d \n",listaIds[lenght].nombre,listaIds[lenght].valor);


      return listaIds[lenght].valor;
}
void yyerror(char* mensaje){
 printf("mi error era: %s",mensaje); 

}

int yyrap()
{	
return 1;
}
