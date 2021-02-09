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
CHAR  [a-zA-Z]
ESCAPES [n,t,",\]


%%
%{
            /** Code executed at the beginning of yylex **/
            yylval = lval;
%}

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

{DIGIT}+	{

    long intValVerify = strtol(yytext);
    if(intValVerify > MAX_INT)
    {
      //throw an error here for integer overflow, aguments are
      errIntOverflow(lineNum,colNum);
      this->yylval->lexeme = new IntLitToken(lineNum, colNum, MAX_INT)
      return MAX_INT;
      //return from function or something
    }
    else
    {
      int intVal = atoi(yytext);
    }
		this->yylval->lexeme = new IntLitToken(lineNum, colNum, intVal);

    //update the colNum count according to the number of
    // characters consumed.
    colNum+= strlen(yytext);

		return TokenKind::INTLITERAL;
		}

\n		{
		lineNum++;
		colNum = 0;
		}
	//This rule captures good string literals, need another rule to capture Unterminated strings
\"([^\\\"]|\\.)*\"	{
    int tokenKind = TokenKind::STRLITERAL;

    this->yylval->lexeme = new StringLitToken(lineNum,colNum,tokenKind);
    colNum += yytext.size();

    return tokenKind;

}
  //Rule for invalid string literals containing bad escape character
\"\\^(ESCAPES)\"{
  errStrEsc(lineNum,colNum);
  return;
}
  //Rule for invalid string literals that are Unterminated and contain bad escape characters
\".\\^(ESCAPES){
    errStrEscAndUnterm(lineNum, colNum);
    return;
}
  //Rule for string literals that are Unterminated
\"([^\\\"]|\\.)*{
  errStrUnterm(lineNum,colNum);
  return;
}


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

.   {
		//TODO: Add the rest of the rules above this point so that legal characters
		// are properly accounted for.
		std::string msg = "Illegal character ";
		msg += yytext;
		error(lineNum,colNum,msg);
		colNum += yyleng;
    }
%%
