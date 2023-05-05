%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include <string.h>


struct tablaInstr
{
    int instr;
    int valor;
    int valor2;
    char nombre[32];
};
struct tablaInstr listaInstr[10];
int line_num = -1;


extern char yytext[];
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);

void mostrarResultado(char* salida);
void guardarInstr(int var,char * nombre, int num, int num2);

%}
%union {char cadena[32]; int num;}
%token F_READ F_WRITE SET MOV_IN MOV_OUT F_TRUNCATE F_SEEK CREATE_SEGMENT IO WAIT SIGNAL F_OPEN F_CLOSE DELETE_SEGMENT EXIT YIELD NEWLINE
%token ID CONSTANTE
%type <cadena> ID  
%type <num> CONSTANTE
%%
programa:  listasentencia EXIT {mostrarResultado("Intruccion correcta \n");}
;
listasentencia: sentencias | listasentencia sentencias
;
sentencias: sentencia1 | sentencia2 | sentencia3 | YIELD NEWLINE { guardarInstr(YIELD-258,"",0,0); } 
;
sentencia1: F_READ ID CONSTANTE CONSTANTE NEWLINE { guardarInstr(F_READ -258,$2,$3,$4); } |
            F_WRITE ID CONSTANTE CONSTANTE NEWLINE { guardarInstr(F_WRITE -258,$2,$3,$4); } 
;
sentencia2: SET  ID CONSTANTE NEWLINE { guardarInstr(SET-258,$2,$3,0); } |
            MOV_IN  ID CONSTANTE NEWLINE { guardarInstr(MOV_IN-258,$2,$3,0); } |
            MOV_OUT  CONSTANTE ID NEWLINE { guardarInstr(MOV_OUT-258,$3,$2,0); } |
            F_TRUNCATE  ID CONSTANTE NEWLINE { guardarInstr(F_TRUNCATE-258,$2,$3,0); } |
            F_SEEK  ID CONSTANTE NEWLINE { guardarInstr(F_SEEK-258,$2,$3,0); } |
            CREATE_SEGMENT  CONSTANTE CONSTANTE NEWLINE { guardarInstr(CREATE_SEGMENT-258,"",$2,$3); } 
;
sentencia3: IO CONSTANTE NEWLINE { guardarInstr(IO-258,"",$2,0); } |
            WAIT ID NEWLINE {  guardarInstr(WAIT-258,$2,0,0);} |
            SIGNAL ID NEWLINE { guardarInstr(SIGNAL-258,$2,0,0); } |
            F_OPEN ID NEWLINE { guardarInstr(F_OPEN-258,$2,0,0); } |
            DELETE_SEGMENT CONSTANTE NEWLINE { guardarInstr(DELETE_SEGMENT-258,"",$2,0); } 
;



%%
int main()
{
        yyparse();
    printf("Instruccion guardada:  %d \n",listaInstr[0].instr);
        printf("Instruccion guardada:  %d \n",listaInstr[1].instr);
        printf("Instruccion guardada:  %d \n",listaInstr[2].instr);
        printf("Instruccion guardada:  %d \n",listaInstr[3].instr);
 int num;
    scanf("%d",&num);


}


void guardarInstr(int var,char * nombre, int num, int num2)
{
    listaInstr[line_num].instr = var;
    listaInstr[line_num].valor = num;
    listaInstr[line_num].valor2 = num2;
    strcpy(listaInstr[line_num].nombre,nombre);

    printf("NUMERO LINEA : %d \n",line_num);
    printf("Instruccion guardada:  %d \n",listaInstr[line_num].instr);
    printf("Instruccion guardada:  %d \n",listaInstr[line_num].valor);
    printf("Instruccion guardada:  %d \n",listaInstr[line_num].valor2);
    printf("Instruccion guardada:  %s \n",listaInstr[line_num].nombre);


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
