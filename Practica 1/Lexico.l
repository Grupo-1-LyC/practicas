%{
#include <stdio.h>
#include <stdlib.h>

FILE  *yyin;
int yylval;
char *yyltext;


int yyerror(void);
int yylex();

%}

%option noyywrap  
%option yylineno 

DIGITO			[0-9]
LETRA			[a-zA-Z]

OP_AS   		[":"]
OP_SUM		    ["+"]
OP_MUL          ["*"]
OP_DIV          ["/"]
OP_RES		    ["-"]
OP_IGUAL        ["="{2}]
OP_DIF          ["!="]
OP_MENOR        ["<"]
OP_MAYOR        [">"]
OP_MENOR_IGUAL  ["<="]
OP_MAYOR_IGUAL  [">="]
CORCHETE_ABRE   ["{"] 
CORCHETE_CIERRE ["}"]
COMA            [","]
CIERRE_DE_LINEA [";"]
PA			    ["("]
PC			    [")"]
CTE_STRING      \".*\"
CTE_ENT		    {OP_RES}?{DIGITO}{1,10}
CTE_FLOAT       {OP_RES}?{DIGITO}{1,3}"."{DIGITO}{1,4}
ID			    {LETRA}({LETRA}|"_")*
DECVAR          "DECVAR"
ENDDEC          "ENDDEC"
write           "write"
while           "while"
if              "if"
else            "else"
Integer         "Integer"
Float           "Float"

%%

{CTE_STRING}        {printf("\nConstante string: %s\n", yytext);return CTE_STRING;}
{CTE_ENT}		    {printf("\nConstante entera: %s\n", yytext);return CTE_ENT;}
{CTE_FLOAT}         {printf("\nConstante flotante: %s\n", yytext);return CTE_FLOAT;}
{ID}			    {printf("\nIdentificador: %s\n", yytext);return ID;}
{OP_AS}			    {printf("\nAsignacion: %s\n", yytext);return OP_AS;}
{OP_SUM}		    {printf("\nSuma: %s\n", yytext);return OP_SUM;}
{OP_MUL}		    {printf("\nMultiplicacion: %s\n", yytext);return OP_MUL;}
{OP_DIV}		    {printf("\nDivision: %s\n", yytext);return OP_DIV;}
{OP_RES}		    {printf("\nResta: %s\n", yytext);return OP_RES;}
{OP_IGUAL}		    {printf("\OPERACION IGUAL: %s\n", yytext);return OP_IGUAL;}
{OP_DIF}		    {printf("\OPERACION DIFERENTE: %s\n", yytext);return OP_DIF;}
{OP_MENOR}		    {printf("\OPERACION MENOR: %s\n", yytext);return OP_MENOR;}
{OP_MAYOR}		    {printf("\OPERACION MAYOR: %s\n", yytext);return OP_MAYOR;}
{OP_MENOR_IGUAL}	{printf("\OPERACION MENOR O IGUAL: %s\n", yytext);return OP_MENOR_IGUAL;}
{OP_MAYOR_IGUAL}	{printf("\OPERACION MAYOR O IGUAL: %s\n", yytext);return OP_MAYOR_IGUAL;}
{CORCHETE_ABRE}		{printf("\CORCHETE ABRE: %s\n", yytext);return CORCHETE_ABRE;}
{CORCHETE_CIERRE}	{printf("\CORCHETE CIERRE: %s\n", yytext);return CORCHETE_CIERRE;}
{COMA}		        {printf("\COMA: %s\n", yytext);return COMA;}
{CIERRE_DE_LINEA}	{printf("\CIERRE DE LINEA: %s\n", yytext);return CIERRE_DE_LINEA;}
{PA}			    {printf("\nParAbre: %s\n", yytext);return PA;}
{PC}			    {printf("\nParCierra: %s\n", yytext);return PC;}
{DECVAR}		    {printf("\DECVAR: %s\n", yytext);return DECVAR;}
{ENDDEC}		    {printf("\ENDDEC: %s\n", yytext);return ENDDEC;}
{write}	            {printf("\write: %s\n", yytext);return write;}
{while}	            {printf("\while: %s\n", yytext);return while;}
{if}		        {printf("\if: %s\n", yytext);return if;}
{else}	            {printf("\else: %s\n", yytext);return else;}
{Integer}		    {printf("\Integer: %s\n", yytext);return Integer;}
{Float}	            {printf("\Float: %s\n", yytext);return Float;}

"\n"      		
"\t"
"\n\t"
" "             		
"\r\n"
.			        {printf("ERROR LEXICO: Caracter no reconocido: %s\n", yytext); exit (0);}

%%

int main(int argc, char *argv[]) 
{
    if ((yyin = fopen(argv[1], "rt")) == NULL)
    {
        printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
    }
    else
    {
        yylex();
    }
    fclose(yyin);
    return 0;
}
