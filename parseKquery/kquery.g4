grammar kquery;

kqueryStart: kquery* EOF;

kquery: array_declaration | query_command;

query_command: 'query';

array_declaration:
	'array' ARRNAME LSQRBRACKET SIZE RSQRBRACKET COLON TYPE ARROW TYPE ASSIGN array_initializer;
array_initializer:
	'symbolic'
	| LSQRBRACKET number_list RSQRBRACKET;
number_list: number | number COMMA number_list;

TYPE: WIDTH (DIGIT)+;

SIZE: (DIGIT)+;

number: 'true' | 'false' | signed_constant;
signed_constant: ('+' | '-') (
		dec_constant
		| bin_constant
		| oct_constant
		| hex_constant
	);
dec_constant: (DIGIT)+;
bin_constant: '0b' ('0' | '1')+;
oct_constant: '0o' (OCTAL)+;
hex_constant: '0x' (HEX)+;

ARRNAME: IDENTIFIER;
IDENTIFIER: [a-zA-Z0-9_][a-zA-Z0-9_]*;
STRING: '"' ('\\' . | ~ ('\\' | '"'))* '"';

WHITESPACE: (' ' | '\n' | '\t' | '\r')+ -> skip;

NUMBER: ('+' | '-')? (DIGIT)+ ('.' (DIGIT)+)?;

SYMBOL: SYMBOL_START (SYMBOL_START | DIGIT)*;

LPAREN: '(';
RPAREN: ')';
WIDTH: 'w';
DOT: '.';
ARROW: '->';
LSQRBRACKET: '[';
RSQRBRACKET: ']';
COLON: ':';
ASSIGN: '=';
COMMA: ',';

HEX: ('0' .. '9' | 'a' .. 'f' | 'A' .. 'F');
OCTAL: ('0' .. '7');
DIGIT: ('0' .. '9');

fragment SYMBOL_START: ('a' .. 'z')
	| ('A' .. 'Z')
	| '+'
	| '-'
	| '*'
	| '/'
	| '.';

fragment IDSYM_1: ('a' .. 'z' | 'A' .. 'Z' | '_');
fragment IDSYM_2: (
		'a' .. 'z'
		| 'A' .. 'Z'
		| '_'
		| '.'
		| '0' .. '9'
	);