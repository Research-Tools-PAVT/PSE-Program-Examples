/*
 
 The MIT License Copyright (c) 2008 Sumit Lahiri 
 
 Permission is hereby granted, free of charge, to
 any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy,
 modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
 persons to whom the Software is furnished to do so, subject to the following conditions: The above
 copyright notice and this permission notice shall be included in all copies or substantial portions
 of the Software. 
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

/*
 Port to Antlr4 by Sumit Lahiri
 */

grammar kquery;

kquery:  array_declaration | query_command EOF;

query_command : 'query' ;

array_declaration : 'array' ARRNAME '[' SIZE ']' ':' DOMAIN '-''>' RANGE '=' array_initializer ;
array_initializer : 'symbolic' | '[' number_list ']'  ;
number_list : number | number ',' number_list  ;

DOMAIN : TYPE ;
RANGE : TYPE ;
SIZE : DIGIT+ ;

number: 'true' | 'false' | signed_constant  ;
signed_constant : ('+' | '-')( dec_constant | bin_constant | oct_constant | hex_constant )  ;
dec_constant : (DIGIT)+  ;
bin_constant : '0b'('0' | '1')+  ;
oct_constant : '0o'(OCTAL)+  ;
hex_constant : '0x'(HEX)+ ;
TYPE : WIDTH (DIGIT)+ ;

ARRNAME : IDENTIFIER ;
IDENTIFIER : (IDSYM_1)(IDSYM_2)* ;

STRING: '"' ('\\' . | ~ ('\\' | '"'))* '"';

WHITESPACE: (' ' | '\n' | '\t' | '\r')+ -> skip;

NUMBER: ('+' | '-')? (DIGIT)+ ('.' (DIGIT)+)?;

SYMBOL: SYMBOL_START (SYMBOL_START | DIGIT)*;

LPAREN: '(';

RPAREN: ')';

WIDTH: 'w';

DOT: '.';

fragment ARROW : '->';

fragment SYMBOL_START: ('a' .. 'z')
	| ('A' .. 'Z')
	| '+'
	| '-'
	| '*'
	| '/'
	| '.';

fragment IDSYM_1 : ('a' .. 'z' | 'A' .. 'Z' | '_');
fragment IDSYM_2 : ('a' .. 'z' | 'A' .. 'Z' | '_' | '.' | '0' .. '9');
fragment HEX : ('0' .. '9' | 'a' .. 'f' | 'A' .. 'F');
fragment OCTAL : ('0' .. '7');
fragment DIGIT: ('0' .. '9');
fragment CAPS: ('A' .. 'Z');
fragment DOWN: ('a' .. 'z');