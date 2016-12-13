flex lex.l
bison -vd yacc.y
cc yacc.tab.c lex.yy.c -ly -ll -v

