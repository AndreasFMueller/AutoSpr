%{
/*
 * expression parser example
 *
 * (c) 2009 Prof Dr Andreas Mueller
 */
extern void	yyerror(char *errmsg);
extern int	yylex(void);
%}
%token NUMBER
%%
exprline:	expr '\n'
	|	expr ';'
	
	;
expr:		term
	|	expr '+' term
	|	expr '-' term
	;
term:		term '*' factor
	|	term '/' factor
	|	factor
	;
factor:		'(' expr ')'
	|	NUMBER
	;

%%

