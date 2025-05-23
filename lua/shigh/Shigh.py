from enum import Enum, auto
import sys
from typing import cast

class TokenKind(Enum): 
#---------------------------------------
    Function = auto()
    Mut = auto()
    Const = auto()

#---------------------------------------
    Open_Paren = auto()
    Close_Paren = auto()
    
    Open_Brace = auto()
    Close_Brace = auto()
    
    Open_Brack = auto()
    Close_Brack = auto()

    Signle_Arrow = auto()
    Semi = auto()
#---------------------------------------
    Plus = auto()
    Minus = auto()
    Mul = auto()
    Slash = auto()
    Mod = auto()
    IsEq = auto()
    NotEq = auto()
    LessThn = auto()
    LessThnEq = auto()
    GreaterThn = auto()
    GreaterThnEq = auto()
    BitAnd = auto()
    BitOr = auto()
    BitXor = auto()
    LeftShift = auto()
    RightShift = auto()
    Log_And = auto()
    Log_Or = auto()

#---------------------------------------
    Inc = auto()
#---------------------------------------
    type_ = auto()
    Ident = auto()
    int_const = auto()
    float_const = auto()
    Comment = auto()
class Token:
    def __init__(self, Kind: TokenKind, Value: str, Line: int, Start: int, End: int):
        self.Kind: TokenKind = Kind 
        self.Value: str = Value
        self.Line: int = Line 
        self.Start: int = Start
        self.End: int = End

    def __repr__(self) -> str:
        return "{" + f'"Kind" : {self.Kind}, "Value" : {self.Value}, "Line" : {self.Line}, "Start" : {self.Start}, "End" : {self.End}' + "}"
class Lexer:
    def __init__(self, SourceCode: str) -> None:
        self.SourceCode: str = SourceCode
    def Lex(self) -> list[Token]:
        Tokens: list[Token] = []
        
        Pos: int = 0
        Col: int = 0
        Line: int  = 0

        def Add(Kind: TokenKind, Value: str, Line: int, Start: int, End: int):
            Tokens.append(Token(Kind, Value, Line, Start, End))

        def index(Pos: int):
            try:
                self.SourceCode[Pos]
            except IndexError:
                return ''
            else:
                return self.SourceCode[Pos]

        while Pos < len(self.SourceCode):
            match self.SourceCode[Pos]:
                case ' ':
                    Pos+=1; Col+=1
                case '\n':
                    Pos+=1; Line+=1; Col = 0
                case '+':
                    Add(TokenKind.Plus, '+', Line, Col, Col + 1)
                    Pos+=1; Col+=1
                case '-':
                    Add(TokenKind.Minus, '-', Line, Col, Col + 1)
                    Pos+=1; Col+=1
                case '*':
                    Add(TokenKind.Mul, '*', Line, Col, Col + 1)
                    Pos+=1; Col+=1
                case '/':
                    if index(Pos + 1) == '/':
                        Start: int = Col
                        while len(self.SourceCode) > Pos and self.SourceCode[Pos] != '\n':
                            print(self.SourceCode[Pos])
                            Pos+=1; Col+=1
                        Add(TokenKind.Comment, "", Line, Start, Col + 1)
                    else:
                        Add(TokenKind.Slash, '/', Line, Col, Col + 1)
                        Pos+=1; Col+=1
                case '%':
                    Add(TokenKind.Mod, '%', Line, Col, Col + 1)
                    Pos+=1; Col+=1
                case '=':
                    if index(Pos + 1) == '=':
                        Add(TokenKind.IsEq, '==', Line, Col, Col + 2)
                        Pos+=2; Col+=2
                case '!':
                    if index(Pos + 1) == '=':
                        Add(TokenKind.NotEq, '!=', Line, Col, Col + 2)
                
                        Pos+=2; Col+=2
                case '<':
                    if index(Pos + 1) == "<":
                        Add(TokenKind.LeftShift, '<<', Line, Col, Col + 2)
                        Pos+=2; Col+=2
                    elif index(Pos + 1) == "=":
                        Add(TokenKind.LessThnEq, '<=', Line, Col, Col + 2)
                        Pos+=2; Col+=2
                    else:
                        Add(TokenKind.LessThn, '<', Line, Col, Col + 1)
                        Pos+=1; Col+=1
                case '>':
                    if index(Pos + 1) == ">":
                        Add(TokenKind.RightShift, '>>', Line, Col, Col + 2)
                        Pos+=2; Col+=2
                    elif index(Pos + 1) == "=":
                        Add(TokenKind.GreaterThnEq, '>=', Line, Col, Col + 2)
                        Pos+=2; Col+=2
                    else:
                        Add(TokenKind.GreaterThn, '<', Line, Col, Col + 1)
                        Pos+=1; Col+=1
                case '&':
                    if index(Pos + 1) == "&":
                        Add(TokenKind.Log_And, '&&', Line, Col, Col + 2)
                        Pos+=2; Col+=2
                    else:
                        Add(TokenKind.BitAnd, '&', Line, Col, Col + 1)
                        Pos+=1; Col+=1
                case '|':
                    if index(Pos + 1) == "|":
                        Add(TokenKind.Log_Or, '||', Line, Col, Col + 2)
                        Pos+=2; Col+=2
                    else:
                        Add(TokenKind.BitOr, '|', Line, Col, Col + 1) 
                        Pos+=1; Col+=1
                case '^':
                    Add(TokenKind.BitXor, '^', Line, Col, Col + 1)
                    Pos+=1; Col+=1
                
                case ';':
                    Add(TokenKind.Semi, ';', Line, Col, Col + 1)
                    Pos+=1; Col+=1
                
                case _:
                    if self.SourceCode[Pos].isdigit():
                        Number: str = ""
                        Start: int = Col 
                        DotCount: int = 0
                        while len(self.SourceCode) > Pos and self.SourceCode[Pos].isdigit() or self.SourceCode[Pos] == '.':
                            if self.SourceCode[Pos] == '_':
                                pass
                            elif self.SourceCode[Pos] == '.':
                                if DotCount == 1:
                                    break
                                DotCount+=1
                            
                            Number+=self.SourceCode[Pos]
                            Pos+=1
                            Col+=1
                            
                        if DotCount == 0:
                            Add(TokenKind.int_const, Number, Line, Start, Col)
                        else:
                            Add(TokenKind.float_const, Number, Line, Start, Col)
                    else:
                        Pos+=1; Col+=1
        return Tokens


def High() -> str:
    Cont: str = "" 
    with open(sys.argv[1], "r") as File:
        Conts = File.read()
        Conts+='\n'
    LexerClass: Lexer = Lexer(Conts)
    Tokens: list[Token] = LexerClass.Lex()

    Pos: int = 0
    while Pos < len(Tokens):
        CToken = Tokens[Pos]

        if CToken.Kind in [TokenKind.int_const, TokenKind.float_const]:
            Cont+=f"{CToken.Line}\n{CToken.Start}\n{CToken.End}\nNumber\n"
            Pos+=1
        elif CToken.Kind in [
                TokenKind.Plus,
                TokenKind.IsEq,
                TokenKind.Minus,
                TokenKind.Mul,
                TokenKind.Slash,
                TokenKind.Mod,
                TokenKind.NotEq,
                TokenKind.LessThn,
                TokenKind.LessThnEq,
                TokenKind.GreaterThn,
                TokenKind.GreaterThnEq,
                TokenKind.BitAnd,
                TokenKind.BitOr,
                TokenKind.BitXor,
                TokenKind.LeftShift,
                TokenKind.RightShift,
                TokenKind.Log_And,
                TokenKind.Log_Or,
            ]:
            Cont+=f"{CToken.Line}\n{CToken.Start}\n{CToken.End}\nOperator\n"
            Pos+=1
        elif CToken.Kind in [TokenKind.Semi]:
            Cont+=f"{CToken.Line}\n{CToken.Start}\n{CToken.End}\nDelimiter\n"
            Pos+=1
        elif CToken.Kind in [TokenKind.Comment]:
            Cont+=f"{CToken.Line}\n{CToken.Start}\n{CToken.End}\nComment\n"
            Pos+=1
        else:
            Pos+=1
    return Cont

with open("/home/devvy/.config/nvim/lua/shigh/Shigh.txt", "w") as File: 
    Cont: str = High()
    File.write(Cont)

