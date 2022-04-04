%{
/*
 * expression parser example
 *
 * (c) 2012 Prof Dr Andreas Mueller
 */
extern void     yyerror(char *errmsg);
extern int      yylex(void);

%}
%union {
	double	value;
}
%token <value>NUMBER
%type <value>expr term factor
%%
exprline:	expr '\n'		{ printf("%f\n", $1); }
	|	expr ';'		{ printf("%f;\n", $1); }
	
	;
expr:		term			{ $$ = $1; }
	|	expr '+' term		{ $$ = $1 + $3; }
	|	expr '-' term		{ $$ = $1 - $3; }
	;
term:		term '*' factor		{ $$ = $1 * $3; }
	|	term '/' factor		{ $$ = $1 / $3; }
	|	factor			{ $$ = $1; }
	;
factor:		'(' expr ')'		{ $$ = $2; }
	|	NUMBER			{ $$ = $1; }
	;
%%

