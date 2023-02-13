grammar jsbach;

// A program has a list of functions (there's no discrimination between the MAIN and other functions), but there HAS to be at least one function (a MAIN if you will)
program : (function)+ EOF
        ;
        
// A function has a name, a list of parameters and a list of (at least one) statement(s)
function: NAME (parameters)? '|:' statements ':|'
        ;
        
// List of parameters (which are essentialy vars)
parameters
        : (VAR)+
        ;

// The different types of statements
statement
          // Assignment (ident CANNOT be of the form l[i]); it can, however, be applied to lists
        : VAR ASSIGN expr                                           # Assign
          // if structure
        | IF expr '|:' statements ':|'                              # If
          // if-then-else structure
        | IF expr '|:' statements ':|' ELSE '|:' statements ':|'    # IfElse
          // while-do statement
        | WHILE expr '|:' statements ':|'                           # While
          // A function/procedure call has a list of arguments in parenthesis (possibly empty)
        | NAME (list_expr)?                                         # Call
          // Read an integer (and ONLY an integer) into a variable (hence why it is only applied to variables)
        | READ VAR                                                  # Read
          // Write an expression
        | WRITE list_expr                                           # Write
          // Play some notes (!); bear in mind that we COULD have a list, in which case we should play ALL elements of the given list
        | PLAY list_expr                                            # Play
          // Trim of list position
        | TRIM VAR '[' expr ']'                                     # Trim
          // Add an element (expr) to a list (VAR)
        | VAR ADD expr                                              # Add
        ;

// List of statements
statements
        : (statement)+
        ;
        
// List of notes
list_note
        : (NOTE)+ 
        ;
        
// Grammar for expressions with relational and aritmetic operators (aside from other operations)
expr    : '{' (list_note)? '}'                          # NoteList
        | VAR '[' expr ']'                              # ListAccess
        | LENGTH VAR                                    # Length
        | expr (MUL|DIV|MOD) expr                       # Arithmetic
        | expr (SUM|SUB) expr                           # Arithmetic
        | expr (EQUAL|NEQUAL|GT|GEQ|LT|LEQ) expr        # Relational
        | '(' expr ')'      			                # Parenths
        | INTVAL                                        # Value
        | VAR                                           # Var
        | NOTE                                          # Note
        | STRING                                        # String
        ;
        
// List of expressions
list_expr
        : (expr)+
        ;

// Lexer Rules

SUM       : '+' ;
SUB       : '-' ;
MUL       : '*';
DIV 	  : '/';
MOD 	  : '%';
ASSIGN    : '<-' ;
READ      : '<?>' ;
WRITE     : '<!>' ;
PLAY      : '<:>' ;
ADD       : '<<' ;
TRIM      : '8<' ;
EQUAL     : '=' ;
NEQUAL	  : '/=';
LT  	  : '<' ;
LEQ 	  : '<=';
GT  	  : '>' ;
GEQ 	  : '>=';
LENGTH    : '#';
IF        : 'if' ;
ELSE      : 'else' ;
WHILE	  : 'while';
INTVAL    : ('0'..'9')+ ;
NOTE      : ( 'A0' | 'B0' | ('A'..'G')('1'..'7')? | 'C8' ) ;
NAME      : ('A'..'Z') ('a'..'z'|'A'..'Z'|'_'|'0'..'9'|'à' .. 'ü')* ;
VAR       : ('a'..'z') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')* ;

// Strings (in quotes) with escape sequences
STRING    : '"' ( ESC_SEQ | ~('\\'|'"') | ('à' .. 'ü') )* '"' ;


fragment
ESC_SEQ   : '\\' ('b'|'t'|'n'|'f'|'r'|'"'|'\''|'\\') ;

// Comments
COMMENT   : '~~~' ~('\n'|'\r')* (' ' .. '~')* '\r'? '~~~' '\n' -> skip ;

// White spaces
WS        : (' '|'\t'|'\r'|'\n')+ -> skip ;
