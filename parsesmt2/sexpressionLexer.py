# Generated from sexpression.g4 by ANTLR 4.7.2
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys



def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\t")
        buf.write("J\b\1\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7")
        buf.write("\4\b\t\b\4\t\t\t\4\n\t\n\3\2\3\2\3\2\3\2\7\2\32\n\2\f")
        buf.write("\2\16\2\35\13\2\3\2\3\2\3\3\6\3\"\n\3\r\3\16\3#\3\3\3")
        buf.write("\3\3\4\5\4)\n\4\3\4\6\4,\n\4\r\4\16\4-\3\4\3\4\6\4\62")
        buf.write("\n\4\r\4\16\4\63\5\4\66\n\4\3\5\3\5\3\5\7\5;\n\5\f\5\16")
        buf.write("\5>\13\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\5\tG\n\t\3\n\3\n")
        buf.write("\2\2\13\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\2\23\2\3\2\6")
        buf.write("\4\2$$^^\5\2\13\f\17\17\"\"\4\2--//\6\2,-/\61C\\c|\2P")
        buf.write("\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13")
        buf.write("\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\3\25\3\2\2\2\5!\3\2")
        buf.write("\2\2\7(\3\2\2\2\t\67\3\2\2\2\13?\3\2\2\2\rA\3\2\2\2\17")
        buf.write("C\3\2\2\2\21F\3\2\2\2\23H\3\2\2\2\25\33\7$\2\2\26\27\7")
        buf.write("^\2\2\27\32\13\2\2\2\30\32\n\2\2\2\31\26\3\2\2\2\31\30")
        buf.write("\3\2\2\2\32\35\3\2\2\2\33\31\3\2\2\2\33\34\3\2\2\2\34")
        buf.write("\36\3\2\2\2\35\33\3\2\2\2\36\37\7$\2\2\37\4\3\2\2\2 \"")
        buf.write("\t\3\2\2! \3\2\2\2\"#\3\2\2\2#!\3\2\2\2#$\3\2\2\2$%\3")
        buf.write("\2\2\2%&\b\3\2\2&\6\3\2\2\2\')\t\4\2\2(\'\3\2\2\2()\3")
        buf.write("\2\2\2)+\3\2\2\2*,\5\23\n\2+*\3\2\2\2,-\3\2\2\2-+\3\2")
        buf.write("\2\2-.\3\2\2\2.\65\3\2\2\2/\61\7\60\2\2\60\62\5\23\n\2")
        buf.write("\61\60\3\2\2\2\62\63\3\2\2\2\63\61\3\2\2\2\63\64\3\2\2")
        buf.write("\2\64\66\3\2\2\2\65/\3\2\2\2\65\66\3\2\2\2\66\b\3\2\2")
        buf.write("\2\67<\5\21\t\28;\5\21\t\29;\5\23\n\2:8\3\2\2\2:9\3\2")
        buf.write("\2\2;>\3\2\2\2<:\3\2\2\2<=\3\2\2\2=\n\3\2\2\2><\3\2\2")
        buf.write("\2?@\7*\2\2@\f\3\2\2\2AB\7+\2\2B\16\3\2\2\2CD\7\60\2\2")
        buf.write("D\20\3\2\2\2EG\t\5\2\2FE\3\2\2\2G\22\3\2\2\2HI\4\62;\2")
        buf.write("I\24\3\2\2\2\r\2\31\33#(-\63\65:<F\3\b\2\2")
        return buf.getvalue()


class sexpressionLexer(Lexer):

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    STRING = 1
    WHITESPACE = 2
    NUMBER = 3
    SYMBOL = 4
    LPAREN = 5
    RPAREN = 6
    DOT = 7

    channelNames = [ u"DEFAULT_TOKEN_CHANNEL", u"HIDDEN" ]

    modeNames = [ "DEFAULT_MODE" ]

    literalNames = [ "<INVALID>",
            "'('", "')'", "'.'" ]

    symbolicNames = [ "<INVALID>",
            "STRING", "WHITESPACE", "NUMBER", "SYMBOL", "LPAREN", "RPAREN", 
            "DOT" ]

    ruleNames = [ "STRING", "WHITESPACE", "NUMBER", "SYMBOL", "LPAREN", 
                  "RPAREN", "DOT", "SYMBOL_START", "DIGIT" ]

    grammarFileName = "sexpression.g4"

    def __init__(self, input=None, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7.2")
        self._interp = LexerATNSimulator(self, self.atn, self.decisionsToDFA, PredictionContextCache())
        self._actions = None
        self._predicates = None


