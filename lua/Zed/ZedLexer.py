from enum import Enum, auto
from typing import Union



class TokenKind(Enum):
    Minus = auto()
    Plus = auto()
    Star = auto()
    Divide = auto()
    Mod = auto()
    
    Inc = auto()
    Dec = auto()


    Int = auto()
    Float = auto()
    String = auto()
    Char = auto()


    Colon_Equals = auto() #there is no suck thing as a walrus operator its called Colon Equals trust me bro
    Equals = auto()
    Colon = auto()

    Comma = auto()

    OpenBrack = auto()
    CloseBrack = auto()
    Open_C_Brack = auto()
    Close_C_Brack = auto() 
    Open_S_Brack = auto()
    Close_S_Brack = auto()

    
    Semi = auto()
    Ident = auto()

    Let = auto()
    Mut = auto()

    Type = auto()

    Null = auto()
    EOF = auto()

Token = dict[str, Union[int, str, TokenKind]]


NullToken: Token = {'Value': 'NULL', 'Kind': TokenKind.Null, 'Line': 0, 'Start': 0, 'End': 0}

class Lexer:
    def __init__(self, Code: str):
        self.SourceCode: str = Code
        self.Err: int = 0

        self.Alphas: dict[str, TokenKind] = {
            #Keywords
            "let" : TokenKind.Let,
            "mut" : TokenKind.Mut,

            #Types
            "i64" : TokenKind.Type,
            "i32" : TokenKind.Type,
            "i16" : TokenKind.Type,
            "i8" : TokenKind.Type,
            "bool" : TokenKind.Type,
            
            "f32" : TokenKind.Type,
            "f64" : TokenKind.Type,
            
            "String" : TokenKind.Type,
            "Any" : TokenKind.Type,
            
        }

    def Lex(self) -> list[Token]:
        Tokens: list[Token] = []
        
        Line: int = 0
        Coloum: int = 0
        Pos: int = 0

        def push(Val: str, Kind: TokenKind, Line: int, Start: int, End: int):
            Tokens.append({"Value": Val, "Kind":Kind, "Line":Line, "Start":Start, "End":End})

        def peek(num: int):
            return self.SourceCode[Pos + num : Pos + num + 1]
        
        while Pos < len(self.SourceCode):
            match self.SourceCode[Pos]:
                case ' ':
                    Pos+=1; Coloum+=1
                
                case '\n':
                    Pos+=1; Coloum = 0; Line+=1
                
                case '+':
                    push("+", TokenKind.Plus, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1                
                
                case '-':
                    push("-", TokenKind.Minus, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1                
                
                case '*':
                    push("*", TokenKind.Star, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1               
                
                case '/':
                    push("/", TokenKind.Divide, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1                
                
                case '%':
                    push("%", TokenKind.Mod, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1
                
                case ';':
                    push(";", TokenKind.Semi, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1
                
                case ':':
                    if peek(1) == "=":
                        push(":=", TokenKind.Colon_Equals, Line, Coloum, Coloum + 2)
                        Pos+=2; Coloum+=2
                    else:
                        push(":", TokenKind.Colon, Line, Coloum, Coloum + 1)
                        Pos+=1; Coloum+=1
                
                case '=':
                    push("=", TokenKind.Equals, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1
                
                case '(':
                    push("(", TokenKind.OpenBrack, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1
                
                case ')':
                    push(")", TokenKind.CloseBrack, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1
                
                case '[':
                    push("[", TokenKind.Open_S_Brack, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1
                
                case ']':
                    push("]", TokenKind.Close_S_Brack, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1                
                
                case '{':
                    push("{", TokenKind.Open_C_Brack, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1
                
                case '}':
                    push("}", TokenKind.Close_C_Brack, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1
                
                case ',':
                    push(",", TokenKind.Comma, Line, Coloum, Coloum + 1)
                    Pos+=1; Coloum+=1
                
                case _:
                    if self.SourceCode[Pos].isdigit():
                        NUMBERLIST = '0123456789abcdefABCDEF_.Xx'
                        NUMBERHEXLIST = "abcdefxABCDEFX"
                        Number: str = ""
                        DotCount: int = 0
                        Start: int = Coloum
                        Dots = []

                        while self.SourceCode[Pos] in NUMBERLIST:
                            if self.SourceCode[Pos] != '_':
                                if self.SourceCode[Pos] == '.':
                                    DotCount+=1
                                    Dots.append(Coloum)

                                Number+=self.SourceCode[Pos]
                            Pos+=1; Coloum+=1

                        if DotCount >= 1:
                            #throw error if hexi decimal
                            if DotCount > 1:
                                exit(1)
                                print("Multiple Points")
                            else:
                                try:
                                    float(Number)
                                except ValueError:
                                    print("No Valid Float")
                                    exit(1)
                            push(Number, TokenKind.Float, Line, Start, Coloum)
                        else: 
                            if Number.lower().startswith('0x'):
                                Number = str(int(Number, 16))

                            ishex = False
                            for i in Number:
                                if i in NUMBERHEXLIST:
                                    ishex = True

                            if ishex == True:
                                print("Not Valid Hex")
                                exit(1)
                                             
                            push(Number, TokenKind.Int, Line, Start, Coloum)
                    elif self.SourceCode[Pos].isalpha() or self.SourceCode[Pos] == '_':
                        Start: int = Coloum
                        Alpha: str = ""
                        while self.SourceCode[Pos].isalnum() or self.SourceCode[Pos] == '_':
                            Alpha+=self.SourceCode[Pos]

                            Pos+=1; Coloum+=1
                        
                        if self.Alphas.get(Alpha) != None:
                            push(Alpha, self.Alphas[Alpha], Line, Start, Coloum)
                        else:
                            push(Alpha, TokenKind.Ident, Line, Start, Coloum)
                    elif self.SourceCode[Pos] == '"':
                        Start: int = Coloum
                        String: str = "\""
                        Got_Unterminated: bool = False
                        Pos+=1; Coloum+=1
                        while True:
                            if String[-1] != '\\' and self.SourceCode[Pos] == '"':
                                break
                            if self.SourceCode[Pos] == '\n':
                                print("New Line In String")
                                exit(1)
                                 
                            String+=self.SourceCode[Pos]
                            Pos+=1; Coloum+=1
                        
                        
                        Pos+=1; Coloum+=1
                        
                        push(String + '"', TokenKind.String, Line, Start, Coloum)
                    elif self.SourceCode[Pos] == "'":
                        Start: int = Coloum
                        Character: str = "'"
                        Got_Unterminated: bool = False
                        Pos+=1; Coloum+=1
                        while True:
                            if Character[-1] != '\\' and self.SourceCode[Pos] == "'":
                                break
                            elif self.SourceCode[Pos] == '\n':
                                exit(1)

                            Character+=self.SourceCode[Pos]
                            Pos+=1; Coloum+=1
                        
                    
                        Pos+=1; Coloum+=1

                        push(Character + "'", TokenKind.Char, Line, Start, Coloum)
                    else:
      
                        Pos+=1; Coloum+=1                                    

        if self.Err > 0:
            exit(1)

       
        return Tokens


if __name__ == "__main__":
    import sys
    print("Applying Hightlight") 
    with open(sys.argv[1]) as File:
        Code = File.read()
        
    with open("ZedLight.txt", 'w') as File:
        File.write("")     
    Code+='\n'        
    LexerClass: Lexer = Lexer(Code)
    LexedTokens = LexerClass.Lex()
    
    NextBracket = "YellowBrack"
    NextBracketList = []

    Pos = 0
    def Add(Line: int, Start: int, End: int, HighLight: str):
        with open("ZedLight.txt", 'a') as File:
            File.write(str(Line) + '\n')
            File.write(str(Start) + '\n')
            File.write(str(End) + '\n')
            File.write(HighLight + '\n')
                 
    VarNameList = []
    while Pos < len(LexedTokens):
        CToken = LexedTokens[Pos]
        
        print(CToken)

        if CToken.get("Kind") in [TokenKind.Int, TokenKind.Float]:
            Add(CToken.get("Line"), CToken.get("Start"), CToken.get("End"), "ZedNumber") # type: ignore
        
        elif CToken.get("Kind") in [TokenKind.String, TokenKind.Char]:
            String = CToken.get("Value")
            StrStart = CToken.get("Start")

            mPos = 1
            Start = 0 
            while mPos  < len(String) - 1:
                if String[mPos] == "\\":
                    print("Fuck")
                    Add(CToken.get("Line"), Start + StrStart, mPos + StrStart, "ZedString")
                    Add(CToken.get("Line"), mPos + StrStart, mPos + 2 + StrStart, "SlashCode")
                    mPos+=1
                    Start = mPos + 1 
                mPos+=1 
            Add(CToken.get("Line"), StrStart + Start, CToken.get("End"), "ZedString")
        elif CToken.get("Kind") in [TokenKind.Let, TokenKind.Mut]:
            Add(CToken.get("Line"), CToken.get('Start'), CToken.get("End"), "ZedLet")
            
            Pos+=1 

            while LexedTokens[Pos].get("Kind") == TokenKind.Ident: 
                VarNameList.append(LexedTokens[Pos].get("Value"))
                CToken = LexedTokens[Pos]
                Add(CToken.get("Line"), CToken.get('Start'), CToken.get("End"), "ZedVar")
                Pos+=1 
                if LexedTokens[Pos].get("Kind") == TokenKind.Comma:
                    Pos+=1 
               
        elif CToken.get("Kind")  == TokenKind.Ident:
            if CToken.get("Value") in VarNameList:
                Add(CToken.get("Line"), CToken.get("Start"), CToken.get("End"), "ZedVar")
        elif CToken.get("Kind") == TokenKind.Type:
            Add(CToken.get("Line"), CToken.get('Start'), CToken.get("End"), "ZedType")
        elif CToken.get("Kind") in [TokenKind.OpenBrack, TokenKind.Open_C_Brack, TokenKind.Open_S_Brack]:
            if len(NextBracketList) == 0:
                NextBracket = "YellowBrack"
            NextBracketList.append(NextBracket)

            Add(CToken.get("Line"), CToken.get("Start"), CToken.get("End"), NextBracket)
            
            if len(NextBracketList) != 0:
                if NextBracket == "YellowBrack":
                    NextBracket = "PurpleBrack"
                else:
                    NextBracket = "YellowBrack" 
            
                
        elif CToken.get("Kind") in [TokenKind.CloseBrack, TokenKind.Close_S_Brack, TokenKind.Close_C_Brack]:
            Add(CToken.get("Line"), CToken.get("Start"), CToken.get("End"), NextBracketList.pop())
        Pos+=1
