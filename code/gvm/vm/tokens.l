%{
/*
 * lexer definition for the basic GVM language
 *
 * (c) 2012 Prof Dr Andreas Mueller, Hochschule Rapperswil
 */
#include <gvm.h>
#include <utils.h>
#include <grammar.h>
extern int	yydebug;
extern gvm_t	gvm;
#undef YY_INPUT
#define YY_INPUT(b, r, ms) (r = gvm_read(b, ms))
#undef yywrap
char	buildstring[1024];
%}
%x readstring
%%
[0-9]+:	{
		yytext[strlen(yytext) - 1] = '\0';
		yylval.lineno = atoi(yytext);
		if (yylval.lineno != yylineno) {
			fprintf(stderr, "wrong line number %d on line %d\n",
				yylval.lineno, yylineno);
			exit(EXIT_FAILURE);
		}
		if (yydebug) {
			printf("lineno: %d\n", yylval.lineno);
		}
		return LINENO;
	}
v[0-9]+	{
		yylval.varno = atoi(&yytext[1]);
		int	nvarsnew = yylval.varno + 1;
		if (nvarsnew > gvm.nvars) {
			if (yydebug) {
				printf("initializing variables from %d to %d\n",
					gvm.nvars, nvarsnew - 1);
			}
			gvm.vars = (mpz_t *)realloc(gvm.vars, nvarsnew * sizeof(mpz_t));
			for (int i = gvm.nvars; i < nvarsnew; i++) {
				if (yydebug) {
					printf("initializing variable %d\n", i);
				}
				mpz_init(gvm.vars[i]);
			}
			gvm.nvars = nvarsnew;
		}
		if (yydebug) {
			printf("varno: %d\n", yylval.varno);
		}
		return VARIABLE;
	}
[0-9]+	{
		mpz_init_set_str(yylval.constant, yytext, 10);
		if (yydebug) {
			gmp_printf("constant: %Zd\n", yylval.constant);
		}
		return CONSTANT;
	}
:=	{
		return ASSIGN;
	}
[*/+\-%]	{
		yylval.operator = yytext[0];
		return OPERATOR;
	}
=	{
		return yytext[0];
	}
IF	{
		return IF;
	}
GOTO	{
		return GOTO;
	}
\"	{
		buildstring[0] = '\0';
		BEGIN(readstring);
	}
<readstring>[^"]	{
		strcat(buildstring, yytext);
	}
<readstring>\\\"	{
		strcat(buildstring, "\"");
	}
<readstring>\" {
		yylval.string = buildstring;
		BEGIN(INITIAL);
		return STRING;
	}
HALT	{
		return HALT;
	}
PRINTVAR {	return PRINTVAR; }
PRINTSTRING {	return PRINTSTRING; }
PRINTTM	{	return PRINTTM; }
		
[ \t]	{ }
\n	{
		yylineno++;
		return yytext[0];
	}


%%
