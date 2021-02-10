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
ESCAPES [nt"\]
ALPHA [a-zA-Z]
RESERVED ["int""bool""byte""string""void""if""else""while""return""array""true""false""read""write""havoc"]

%%
%{
            /** Code executed at the beginning of yylex **/
            yylval = lval;
%}


  //identifier rule DOESN'T HANDLE RESERVED KEYWORDS YET
[_a-zA-Z0-9]+ { //This could be done better i think
    int tokenKind = TokenKind::ID;
    colNum++;
    Token* token = new IDToken(lineNum, colNum, yytext);
    this->yylval->lexeme = token;
    return tokenKind;
}

"+"		{
		// Keep track of the "kind" of token we matched. In this case,
		// it's a CROSS (aka the plus symbol). The full list of token
		// kinds is declared around line 197 of grammar.hh. The testing
		// functionScanner::outputTokens also indicates what each token
		// represents (declared in scanner.cpp line 9)
		int tokenKind = TokenKind::CROSS;

		//Instatiate a token. There are 4 classes of tokens defined based on
		// - a literal string(StringLitToken)
		// - a literal integer (IntLitToken)
		// - an identifier (IDToken)
		// - a base Token (any other type)
		// The token object is a handy place to keep information about the
		// token (i.e. token metadata) such as the line and column on which
		// the token character started (which can be used later in debug
		// messages, etc).
		Token * token = new Token(lineNum, colNum, tokenKind);

		//Assign the token to a instance variable of the scanner.
		// (When Flex processes a .l file in C++ mode, it creates
		// a class called Scanner, which is a subclass of yyFlexScanner)
		// By assigning a value to this field, we put the token
		// metadata in a place where scanner's client program can find it.
		this->yylval->lexeme = token;

		//Since we consumed 1 character, increase the column number by 1
		colNum++;

		//Let the scanner's client program know that a CROSS token
		// has been matched
		return tokenKind;
		}

"-" {
		//Essentially the same thing as CROSS, but without the verbose
		// comments so it doesn't look so scary.
		int tokenKind = TokenKind::DASH;
		this->yylval->lexeme = new Token(lineNum, colNum, tokenKind);
		colNum++;
		return tokenKind;
		}

"["	{
  	int tokenKind = TokenKind::LBRACE;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"]"	{
  	int tokenKind = TokenKind::RBRACE;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"{"	{
  	int tokenKind = TokenKind::LCURLY;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"}"	{
  	int tokenKind = TokenKind::RCURLY;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"("	{
  	int tokenKind = TokenKind::LPAREN;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

")"	{
  	int tokenKind = TokenKind::RPAREN;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

";"	{
  	int tokenKind = TokenKind::SEMICOLON;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

":"	{
  	int tokenKind = TokenKind::COLON;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

","	{
  	int tokenKind = TokenKind::COMMA;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"--"	{
  	int tokenKind = TokenKind::DASHDASH;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum = colNum + 2;
  	return tokenKind;
	}

"++"	{
  	int tokenKind = TokenKind::CROSSCROSS;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum = colNum + 2;
  	return tokenKind;
	}

"*"	{
  	int tokenKind = TokenKind::STAR;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"/"	{
  	int tokenKind = TokenKind::SLASH;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"!"	{
  	int tokenKind = TokenKind::NOT;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"=="	{
  	int tokenKind = TokenKind::EQUALS;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum = colNum + 2;
  	return tokenKind;
	}

"!="	{
  	int tokenKind = TokenKind::NOTEQUALS;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum = colNum + 2;
  	return tokenKind;
	}

"<"	{
  	int tokenKind = TokenKind::LESS;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

">"	{
  	int tokenKind = TokenKind::GREATER;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"<="	{
  	int tokenKind = TokenKind::LESSEQ;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum = colNum + 2;
  	return tokenKind;
	}

">="	{
  	int tokenKind = TokenKind::GREATEREQ;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum = colNum + 2;
  	return tokenKind;
	}

"="	{
  	int tokenKind = TokenKind::ASSIGN;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum++;
  	return tokenKind;
	}

"&&"	{
  	int tokenKind = TokenKind::AND;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum = colNum + 2;
  	return tokenKind;
	}

"||"	{
  	int tokenKind = TokenKind::OR;
  	Token *token = new Token(lineNum, colNum, tokenKind);
  	this->yylval->lexeme = token;
  	colNum = colNum + 2;
  	return tokenKind;
	}

{DIGIT}+	{

    long intValVerify = strtol(yytext, NULL, 10);
    if(intValVerify > INT_MAX)
    {
      errIntOverflow(lineNum,colNum);
      this->yylval->lexeme = new IntLitToken(lineNum, colNum, INT_MAX);
      return INT_MAX;
    }
    else
    {
      int intVal = atoi(yytext);
      colNum++;
      this->yylval->lexeme = new IntLitToken(lineNum, colNum, intVal);

  		return TokenKind::INTLITERAL;
    }

		}

\n {
		lineNum++;
		colNum = 0;
		}

\"(\\.|[^\\"])*\" {
        int tokenKind = TokenKind::STRLITERAL;
        colNum++;
        Token* token = new StrToken(lineNum, colNum, yytext);
        this->yylval->lexeme = token;
        return tokenKind;
      }
      /*
\".\\^{ESCAPES} {
              errStrEscAndUnterm(lineNum, colNum);
              return;
  }*/

"int"		{
		int tokenKind = TokenKind::INT;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 3;
		return tokenKind;
		}

"bool"		{
		int tokenKind = TokenKind::BOOL;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 4;
		return tokenKind;
		}

"byte"		{
		int tokenKind = TokenKind::BYTE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 4;
		return tokenKind;
		}

"string"	{
		int tokenKind = TokenKind::STRING;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 5;
		return tokenKind;
		}

"void"		{
		int tokenKind = TokenKind::VOID;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 4;
		return tokenKind;
		}

"if"		{
		int tokenKind = TokenKind::IF;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 2;
		return tokenKind;
		}

"else"		{
		int tokenKind = TokenKind::ELSE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 4;
		return tokenKind;
		}

"while"		{
		int tokenKind = TokenKind::WHILE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 5;
		return tokenKind;
		}

"return"	{
		int tokenKind = TokenKind::RETURN;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 6;
		return tokenKind;
		}

"array"		{
		int tokenKind = TokenKind::ARRAY;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 5;
		return tokenKind;
		}

"true"		{
		int tokenKind = TokenKind::TRUE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 4;
		return tokenKind;
		}

"false"		{
		int tokenKind = TokenKind::FALSE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 5;
		return tokenKind;
		}

"read"		{
		int tokenKind = TokenKind::READ;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 4;
		return tokenKind;
		}

"write"		{
		int tokenKind = TokenKind::WRITE;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 5;
		return tokenKind;
		}

"havoc"		{
		int tokenKind = TokenKind::HAVOC;
		Token *token = new Token(lineNum, colNum, tokenKind);
		this->yylval->lexeme = token;
		colNum = colNum + 5;
		return tokenKind;
		}

<<EOF>>   	{
    		colNum++;
    		return 0;
    		}

.   {
		//TODO: Add the rest of the rules above this point so that legal characters
		// are properly accounted for.
		std::string msg = "Illegal character ";
		msg += yytext;
		error(lineNum,colNum,msg);
		colNum += yyleng;
    }
%%
