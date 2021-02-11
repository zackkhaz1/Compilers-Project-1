%{
#include <string>
#include <limits.h>
#include <bits/stdc++.h>

/* Get our custom yyFlexScanner subclass */
#include "scanner.hpp"
#include "tokens.hpp"
#undef  YY_DECL
#define YY_DECL int crona::Scanner::yylex( crona::Parser::semantic_type * const lval )

/* define yyterminate as this instead of NULL */
#define yyterminate() return( TokenKind::END )

/* Exclude unistd.h for Visual Studio compatability. */
#define YY_NO_UNISTD_H

/* typedef to make the reference to token kinds shorter */
using TokenKind = crona::Parser::token;

%}

%option debug
%option nodefault
%option yyclass="crona::Scanner"
%option noyywrap
%option c++

DIGIT [0-9]

%%
%{
            /** Code executed at the beginning of yylex **/
            yylval = lval;
%}

    //************RESERVED WORD TOKENS************//
    //*******************************************//
"int"		{
		int tokenKind = TokenKind::INT;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"bool"		{
		int tokenKind = TokenKind::BOOL;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"byte"		{
		int tokenKind = TokenKind::BYTE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"string"	{
		int tokenKind = TokenKind::STRING;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"void"		{
		int tokenKind = TokenKind::VOID;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"if"		{
		int tokenKind = TokenKind::IF;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"else"		{
		int tokenKind = TokenKind::ELSE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"while"		{
		int tokenKind = TokenKind::WHILE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"return"	{
		int tokenKind = TokenKind::RETURN;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"array"		{
		int tokenKind = TokenKind::ARRAY;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"true"		{
		int tokenKind = TokenKind::TRUE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"false"		{
		int tokenKind = TokenKind::FALSE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"read"		{
		int tokenKind = TokenKind::READ;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"write"		{
		int tokenKind = TokenKind::WRITE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

"havoc"		{
		int tokenKind = TokenKind::HAVOC;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum += yyleng;
		return tokenKind;
		}

    //************END RESERVED WORD TOKENS************//
    //***********************************************//

[a-zA-Z_][a-zA-Z0-9_]*	{
    				int tokenKind = TokenKind::ID;
    				Token* token = new IDToken(lineNum, colNum, yytext);
    				this->yylval->lexeme = token;
    				colNum += yyleng;
    				return tokenKind;
				}

[ \s\t]		{ colNum += yyleng; }

"+"	{

	int tokenKind = TokenKind::CROSS;

	Token * token = new Token(lineNum, colNum, tokenKind);

	this->yylval->lexeme = token;

	colNum++;
	return tokenKind;
	}

  //************SYMBOL TOKENS***********************//
  //***********************************************//
"-" 	{
	int tokenKind = TokenKind::DASH;
	this->yylval->lexeme = new Token(lineNum, colNum, tokenKind);
	colNum += yyleng;
	return tokenKind;
	}

"["	{
	int tokenKind = TokenKind::LBRACE;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"]"	{
	int tokenKind = TokenKind::RBRACE;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"{"	{
	int tokenKind = TokenKind::LCURLY;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"}"	{
	int tokenKind = TokenKind::RCURLY;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"("	{
	int tokenKind = TokenKind::LPAREN;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

")"	{
	int tokenKind = TokenKind::RPAREN;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

";"	{
	int tokenKind = TokenKind::SEMICOLON;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

":"	{
	int tokenKind = TokenKind::COLON;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

","	{
	int tokenKind = TokenKind::COMMA;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"--"	{
	int tokenKind = TokenKind::DASHDASH;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"++"	{
	int tokenKind = TokenKind::CROSSCROSS;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"*"	{
	int tokenKind = TokenKind::STAR;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"/"	{
	int tokenKind = TokenKind::SLASH;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"!"	{
	int tokenKind = TokenKind::NOT;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"=="	{
	int tokenKind = TokenKind::EQUALS;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"!="	{
	int tokenKind = TokenKind::NOTEQUALS;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"<"	{
	int tokenKind = TokenKind::LESS;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

">"	{
	int tokenKind = TokenKind::GREATER;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"<="	{
	int tokenKind = TokenKind::LESSEQ;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

">="	{
	int tokenKind = TokenKind::GREATEREQ;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"="	{
	int tokenKind = TokenKind::ASSIGN;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"&&"	{
	int tokenKind = TokenKind::AND;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

"||"	{
	int tokenKind = TokenKind::OR;
	Token *token = new Token(lineNum, colNum, tokenKind);
	this->yylval->lexeme = token;
	colNum += yyleng;
	return tokenKind;
	}

  //************END SYMBOL TOKENS*******************//
  //***********************************************//

{DIGIT}+	{
			long intValVerify = strtol(yytext, NULL, 10);
			if(intValVerify > INT_MAX){
				errIntOverflow(lineNum,colNum);
				this->yylval->lexeme = new IntLitToken(lineNum, colNum, INT_MAX);
				colNum += yyleng;
				return INT_MAX;
    			}
			else{
				int intVal = atoi(yytext);
				this->yylval->lexeme = new IntLitToken(lineNum, colNum, intVal);
				colNum += yyleng;
				return TokenKind::INTLITERAL;
			}
		}



    //************STRING LITERAL RULES****************//
    //***********************************************//
\"(\\.|[^\\"\n])*	{
			errStrUnterm(lineNum, colNum);
			colNum = 1;
			}

\"(\\[nt'"\\]|[^\\"\n])*\\[^\nnt"\\]([^\n"])*\"		{
							errStrEsc(lineNum, colNum);
							colNum = 1;
							}

\"(\\[nt'"\\]|[^\\"\n])*(\\[^\nnt"\\])?([^\\"\n]|\\[nt'"\\])*\\?	{
									errStrEscAndUnterm(lineNum, colNum);
									colNum = 1;
									}



"//".*\n|\n 	{
		// For commented line and new line case
		lineNum++;
		colNum = 1;
		}

\"(\\.|[^\\"\n])*\"	{
			int tokenKind = TokenKind::STRLITERAL;
			Token* token = new StrToken(lineNum, colNum, yytext);
			this->yylval->lexeme = token;
			colNum += yyleng;
			return tokenKind;
			}
  //************END STRING LITERAL RULES************//
  //***********************************************//
.	{
	std::string msg = "Illegal character ";
	msg += yytext;
	error(lineNum,colNum,msg);
	colNum += yyleng;
	}
%%
