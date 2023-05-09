%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include <string.h>
#include "list.h"


 typedef struct 
{
    int instr;
    int valor;
    int valor2;
    char nombre[32];
    char nombre2[32];

}tablaInstr;
tablaInstr listaInstr;
	t_list * lista;
int line_num = -1;

extern char yytext[];
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);

void mostrarResultado(char* salida);
void guardarInstr(int var,char * nombre, int num, int num2,char * nombre2);

%}
%union {char cadena[32]; int num;}
%token F_READ F_WRITE SET MOV_IN MOV_OUT F_TRUNCATE F_SEEK CREATE_SEGMENT IO WAIT SIGNAL F_OPEN F_CLOSE DELETE_SEGMENT EXIT YIELD NEWLINE
%token ID CONSTANTE
%type <cadena> ID  
%type <num> CONSTANTE
%%
programa:  listasentencia EXIT {guardarInstr(EXIT-258,"",0,0,""); mostrarResultado("Intruccion correcta \n");}
;
listasentencia: sentencias | listasentencia sentencias
;
sentencias: sentencia1 | sentencia2 | sentencia3 | YIELD NEWLINE { guardarInstr(YIELD-258,"",0,0,""); } 
;
sentencia1: F_READ ID CONSTANTE CONSTANTE NEWLINE { guardarInstr(F_READ -258,$2,$3,$4,""); } |
            F_WRITE ID CONSTANTE CONSTANTE NEWLINE { guardarInstr(F_WRITE -258,$2,$3,$4,""); } 
;
sentencia2: SET  ID ID NEWLINE { guardarInstr(SET-258,$2,0,0,$3); } |
            MOV_IN  ID CONSTANTE NEWLINE { guardarInstr(MOV_IN-258,$2,$3,0,""); } |
            MOV_OUT  CONSTANTE ID NEWLINE { guardarInstr(MOV_OUT-258,$3,$2,0,""); } |
            F_TRUNCATE  ID CONSTANTE NEWLINE { guardarInstr(F_TRUNCATE-258,$2,$3,0,""); } |
            F_SEEK  ID CONSTANTE NEWLINE { guardarInstr(F_SEEK-258,$2,$3,0,""); } |
            CREATE_SEGMENT  CONSTANTE CONSTANTE NEWLINE { guardarInstr(CREATE_SEGMENT-258,"",$2,$3,""); } 
;
sentencia3: IO CONSTANTE NEWLINE { guardarInstr(IO-258,"",$2,0,""); } |
            WAIT ID NEWLINE {  guardarInstr(WAIT-258,$2,0,0,"");} |
            SIGNAL ID NEWLINE { guardarInstr(SIGNAL-258,$2,0,0,""); } |
            F_OPEN ID NEWLINE { guardarInstr(F_OPEN-258,$2,0,0,""); } |
            F_CLOSE ID NEWLINE { guardarInstr(F_CLOSE-258,$2,0,0,""); } |
            DELETE_SEGMENT CONSTANTE NEWLINE { guardarInstr(DELETE_SEGMENT-258,"",$2,0,""); } 
;



%%
/*t_list crearLista(char* argv)   //PARA CORRERLO EN TP
{
        FILE *yyin;
        yyin=fopen(argv[1],"r");
        yyrestart(yyin);
        lista = list_create();
        yyparse();

        return *lista;

}

*/
t_list main(int argc, char** argv)
{
        FILE *yyin;
        yyin=fopen(argv[1],"r");
        yyrestart(yyin);
        lista = list_create();
        yyparse();

        return *lista;

}

void printLista(void* data) {
    tablaInstr* tabla = (tablaInstr*) data;
    printf("ID: %d\n", tabla->instr);
}
void guardarInstr(int var,char * nombre, int num, int num2,char * nombre2)
{
    listaInstr.instr = var;
    listaInstr.valor = num;
    listaInstr.valor2 = num2;
    strcpy(listaInstr.nombre,nombre);
        strcpy(listaInstr.nombre2,nombre2);

list_add(lista,&listaInstr);
printLista(list_get(lista,line_num));

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
