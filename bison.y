%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include <string.h>


struct tablaVars
{
    int instr;
    int valor;
    int valor2;
    char nombre[32];
};
struct tablaVars listaIds[10];
int contadorVar=0;
int line_num = -1;


extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);

void mostrarResultado(char* salida);
void asignarVar(int var,char * nombre, int num, int num2);

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
sentencias: sentencia1 | sentencia2 | sentencia3 | YIELD NEWLINE { asignarVar(YIELD-258,"",0,0); contadorVar++;} 
;
sentencia1: F_READ ID CONSTANTE CONSTANTE NEWLINE { asignarVar(F_READ -258,$2,$3,$4); contadorVar++;} |
            F_WRITE ID CONSTANTE CONSTANTE NEWLINE { asignarVar(F_WRITE -258,$2,$3,$4); contadorVar++;} 
;
sentencia2: SET  ID CONSTANTE NEWLINE { asignarVar(SET-258,$2,$3,0); contadorVar++;} |
            MOV_IN  ID CONSTANTE NEWLINE { asignarVar(MOV_IN-258,$2,$3,0); contadorVar++;} |
            MOV_OUT  CONSTANTE ID NEWLINE { asignarVar(MOV_OUT-258,$3,$2,0); contadorVar++;} |
            F_TRUNCATE  ID CONSTANTE NEWLINE { asignarVar(F_TRUNCATE-258,$2,$3,0); contadorVar++;} |
            F_SEEK  ID CONSTANTE NEWLINE { asignarVar(F_SEEK-258,$2,$3,0); contadorVar++;} |
            CREATE_SEGMENT  CONSTANTE CONSTANTE NEWLINE { asignarVar(CREATE_SEGMENT-258,"",$2,$3); contadorVar++;} 
;
sentencia3: IO CONSTANTE NEWLINE { asignarVar(IO-258,"",$2,0); contadorVar++;} |
            WAIT ID NEWLINE { asignarVar(WAIT-258,$2,0,0); contadorVar++;} |
            SIGNAL ID NEWLINE { asignarVar(SIGNAL-258,$2,0,0); contadorVar++;} |
            F_OPEN ID NEWLINE { asignarVar(F_OPEN-258,$2,0,0); contadorVar++;} |
            DELETE_SEGMENT CONSTANTE NEWLINE { asignarVar(DELETE_SEGMENT-258,"",$2,0); contadorVar++;} 
;



%%
int main()
{
        yyparse();
    printf("parametros asignada: %d \n",listaIds[0].instr);
        printf("parametros asignada: %d \n",listaIds[1].instr);
        printf("parametros asignada: %d \n",listaIds[2].instr);
        printf("parametros asignada: %d \n",listaIds[3].instr);
 int num;
    scanf("%d",&num);


}


void asignarVar(int var,char * nombre, int num, int num2)
{
    int lenght=0;
    for (int i = 0; yytext[i] != ' '; i++) lenght++;
    char identificador[32];
    strncpy(identificador,&nombre[0],lenght+1);

    listaIds[line_num].instr = var;
    listaIds[line_num].valor = num;
    listaIds[line_num].valor2 = num2;
    strcpy(listaIds[line_num].nombre,identificador);

    printf("NUMERO LINEA : %d \n",line_num);
    printf("parametros asignada: %d \n",listaIds[line_num].instr);
    printf("parametros asignada: %d \n",listaIds[line_num].valor);
    printf("parametros asignada: %d \n",listaIds[line_num].valor2);
    printf("parametros asignada: %s \n",listaIds[line_num].nombre);


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
