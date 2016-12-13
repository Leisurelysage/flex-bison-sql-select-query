%token STRING
%token NOT
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token COMMA
%token COMPARISON
%token NUMBER
%token SELECT
%token DISTINCTALL
%token FROM
%token WHERE
%token ID
%token OR
%token AND
%token ALL
%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char*);
  extern int line;
  extern int position;
%}
%%
select_statement:
  SELECT fields_list from_clause where_clause
  | SELECT fields_list from_clause
  | error fields_list from_clause where_clause { yyerror(" Missed 'SELECT'! ");};

where_clause:
  WHERE condition
  |error condition { yyerror(" Missed 'WHERE'! "); };

from_clause:
  FROM list
  | FROM error { yyerror("Missed id!"); };

condition:
  condition1
  | condition1 OR condition
  | condition1 AND condition;

fields_list:
  ALL
  | list;

list:
  ID
  | list COMMA ID;

condition1:
  condition2
  | NOT condition2;

condition2:
  ID COMPARISON value_field
  | ID error value_field { yyerror(" No comparison operation! "); }
  | ID COMPARISON error { yyerror(" No value on the right! ");}
  | error COMPARISON value_field { yyerror(" No identifier on the left! "); }
  | error { yyerror(" Missed condition! "); };
value_field:
  STRING
  | NUMBER;
%%
void yyerror(char*s)
{
  fprintf(stderr,"error %s at line %d position %d \n", s, line, position);
}
