# Generated from kquery.g4 by ANTLR 4.7.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3#")
        buf.write("f\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b")
        buf.write("\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\4\r\t\r\3\2\7\2")
        buf.write("\34\n\2\f\2\16\2\37\13\2\3\2\3\2\3\3\3\3\5\3%\n\3\3\4")
        buf.write("\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3")
        buf.write("\6\3\6\3\6\3\6\3\6\5\6:\n\6\3\7\3\7\3\7\3\7\3\7\5\7A\n")
        buf.write("\7\3\b\3\b\3\b\5\bF\n\b\3\t\3\t\3\t\3\t\3\t\5\tM\n\t\3")
        buf.write("\n\6\nP\n\n\r\n\16\nQ\3\13\3\13\6\13V\n\13\r\13\16\13")
        buf.write("W\3\f\3\f\6\f\\\n\f\r\f\16\f]\3\r\3\r\6\rb\n\r\r\r\16")
        buf.write("\rc\3\r\2\2\16\2\4\6\b\n\f\16\20\22\24\26\30\2\4\3\2\b")
        buf.write("\t\3\2\13\f\2f\2\35\3\2\2\2\4$\3\2\2\2\6&\3\2\2\2\b(\3")
        buf.write("\2\2\2\n9\3\2\2\2\f@\3\2\2\2\16E\3\2\2\2\20G\3\2\2\2\22")
        buf.write("O\3\2\2\2\24S\3\2\2\2\26Y\3\2\2\2\30_\3\2\2\2\32\34\5")
        buf.write("\4\3\2\33\32\3\2\2\2\34\37\3\2\2\2\35\33\3\2\2\2\35\36")
        buf.write("\3\2\2\2\36 \3\2\2\2\37\35\3\2\2\2 !\7\2\2\3!\3\3\2\2")
        buf.write("\2\"%\5\b\5\2#%\5\6\4\2$\"\3\2\2\2$#\3\2\2\2%\5\3\2\2")
        buf.write("\2&\'\7\3\2\2\'\7\3\2\2\2()\7\4\2\2)*\7\21\2\2*+\7\34")
        buf.write("\2\2+,\7\20\2\2,-\7\35\2\2-.\7\36\2\2./\7\17\2\2/\60\7")
        buf.write("\33\2\2\60\61\7\17\2\2\61\62\7\37\2\2\62\63\5\n\6\2\63")
        buf.write("\t\3\2\2\2\64:\7\5\2\2\65\66\7\34\2\2\66\67\5\f\7\2\67")
        buf.write("8\7\35\2\28:\3\2\2\29\64\3\2\2\29\65\3\2\2\2:\13\3\2\2")
        buf.write("\2;A\5\16\b\2<=\5\16\b\2=>\7 \2\2>?\5\f\7\2?A\3\2\2\2")
        buf.write("@;\3\2\2\2@<\3\2\2\2A\r\3\2\2\2BF\7\6\2\2CF\7\7\2\2DF")
        buf.write("\5\20\t\2EB\3\2\2\2EC\3\2\2\2ED\3\2\2\2F\17\3\2\2\2GL")
        buf.write("\t\2\2\2HM\5\22\n\2IM\5\24\13\2JM\5\26\f\2KM\5\30\r\2")
        buf.write("LH\3\2\2\2LI\3\2\2\2LJ\3\2\2\2LK\3\2\2\2M\21\3\2\2\2N")
        buf.write("P\7#\2\2ON\3\2\2\2PQ\3\2\2\2QO\3\2\2\2QR\3\2\2\2R\23\3")
        buf.write("\2\2\2SU\7\n\2\2TV\t\3\2\2UT\3\2\2\2VW\3\2\2\2WU\3\2\2")
        buf.write("\2WX\3\2\2\2X\25\3\2\2\2Y[\7\r\2\2Z\\\7\"\2\2[Z\3\2\2")
        buf.write("\2\\]\3\2\2\2][\3\2\2\2]^\3\2\2\2^\27\3\2\2\2_a\7\16\2")
        buf.write("\2`b\7!\2\2a`\3\2\2\2bc\3\2\2\2ca\3\2\2\2cd\3\2\2\2d\31")
        buf.write("\3\2\2\2\f\35$9@ELQW]c")
        return buf.getvalue()


class kqueryParser (Parser):

    grammarFileName = "kquery.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [DFA(ds, i) for i, ds in enumerate(atn.decisionToState)]

    sharedContextCache = PredictionContextCache()

    literalNames = ["<INVALID>", "'query'", "'array'", "'symbolic'", "'true'",
                    "'false'", "'+'", "'-'", "'0b'", "'0'", "'1'", "'0o'",
                    "'0x'", "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>",
                    "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>",
                    "'('", "')'", "'w'", "'.'", "'->'", "'['", "']'", "':'",
                    "'='", "','"]

    symbolicNames = ["<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>",
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>",
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>",
                     "<INVALID>", "TYPE", "SIZE", "ARRNAME", "IDENTIFIER",
                     "STRING", "WHITESPACE", "NUMBER", "SYMBOL", "LPAREN",
                     "RPAREN", "WIDTH", "DOT", "ARROW", "LSQRBRACKET",
                     "RSQRBRACKET", "COLON", "ASSIGN", "COMMA", "HEX",
                     "OCTAL", "DIGIT"]

    RULE_kqueryStart = 0
    RULE_kquery = 1
    RULE_query_command = 2
    RULE_array_declaration = 3
    RULE_array_initializer = 4
    RULE_number_list = 5
    RULE_number = 6
    RULE_signed_constant = 7
    RULE_dec_constant = 8
    RULE_bin_constant = 9
    RULE_oct_constant = 10
    RULE_hex_constant = 11

    ruleNames = ["kqueryStart", "kquery", "query_command", "array_declaration",
                 "array_initializer", "number_list", "number", "signed_constant",
                 "dec_constant", "bin_constant", "oct_constant", "hex_constant"]

    EOF = Token.EOF
    T__0 = 1
    T__1 = 2
    T__2 = 3
    T__3 = 4
    T__4 = 5
    T__5 = 6
    T__6 = 7
    T__7 = 8
    T__8 = 9
    T__9 = 10
    T__10 = 11
    T__11 = 12
    TYPE = 13
    SIZE = 14
    ARRNAME = 15
    IDENTIFIER = 16
    STRING = 17
    WHITESPACE = 18
    NUMBER = 19
    SYMBOL = 20
    LPAREN = 21
    RPAREN = 22
    WIDTH = 23
    DOT = 24
    ARROW = 25
    LSQRBRACKET = 26
    RSQRBRACKET = 27
    COLON = 28
    ASSIGN = 29
    COMMA = 30
    HEX = 31
    OCTAL = 32
    DIGIT = 33

    def __init__(self, input: TokenStream, output: TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7.2")
        self._interp = ParserATNSimulator(
            self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None

    class KqueryStartContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def EOF(self):
            return self.getToken(kqueryParser.EOF, 0)

        def kquery(self, i: int = None):
            if i is None:
                return self.getTypedRuleContexts(kqueryParser.KqueryContext)
            else:
                return self.getTypedRuleContext(kqueryParser.KqueryContext, i)

        def getRuleIndex(self):
            return kqueryParser.RULE_kqueryStart

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterKqueryStart"):
                listener.enterKqueryStart(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitKqueryStart"):
                listener.exitKqueryStart(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitKqueryStart"):
                return visitor.visitKqueryStart(self)
            else:
                return visitor.visitChildren(self)

    def kqueryStart(self):

        localctx = kqueryParser.KqueryStartContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_kqueryStart)
        self._la = 0  # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 27
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while _la == kqueryParser.T__0 or _la == kqueryParser.T__1:
                self.state = 24
                self.kquery()
                self.state = 29
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 30
            self.match(kqueryParser.EOF)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class KqueryContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def array_declaration(self):
            return self.getTypedRuleContext(kqueryParser.Array_declarationContext, 0)

        def query_command(self):
            return self.getTypedRuleContext(kqueryParser.Query_commandContext, 0)

        def getRuleIndex(self):
            return kqueryParser.RULE_kquery

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterKquery"):
                listener.enterKquery(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitKquery"):
                listener.exitKquery(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitKquery"):
                return visitor.visitKquery(self)
            else:
                return visitor.visitChildren(self)

    def kquery(self):

        localctx = kqueryParser.KqueryContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_kquery)
        try:
            self.state = 34
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [kqueryParser.T__1]:
                self.enterOuterAlt(localctx, 1)
                self.state = 32
                self.array_declaration()
                pass
            elif token in [kqueryParser.T__0]:
                self.enterOuterAlt(localctx, 2)
                self.state = 33
                self.query_command()
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Query_commandContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def getRuleIndex(self):
            return kqueryParser.RULE_query_command

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterQuery_command"):
                listener.enterQuery_command(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitQuery_command"):
                listener.exitQuery_command(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitQuery_command"):
                return visitor.visitQuery_command(self)
            else:
                return visitor.visitChildren(self)

    def query_command(self):

        localctx = kqueryParser.Query_commandContext(
            self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_query_command)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 36
            self.match(kqueryParser.T__0)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Array_declarationContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def ARRNAME(self):
            return self.getToken(kqueryParser.ARRNAME, 0)

        def LSQRBRACKET(self):
            return self.getToken(kqueryParser.LSQRBRACKET, 0)

        def SIZE(self):
            return self.getToken(kqueryParser.SIZE, 0)

        def RSQRBRACKET(self):
            return self.getToken(kqueryParser.RSQRBRACKET, 0)

        def COLON(self):
            return self.getToken(kqueryParser.COLON, 0)

        def TYPE(self, i: int = None):
            if i is None:
                return self.getTokens(kqueryParser.TYPE)
            else:
                return self.getToken(kqueryParser.TYPE, i)

        def ARROW(self):
            return self.getToken(kqueryParser.ARROW, 0)

        def ASSIGN(self):
            return self.getToken(kqueryParser.ASSIGN, 0)

        def array_initializer(self):
            return self.getTypedRuleContext(kqueryParser.Array_initializerContext, 0)

        def getRuleIndex(self):
            return kqueryParser.RULE_array_declaration

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterArray_declaration"):
                listener.enterArray_declaration(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitArray_declaration"):
                listener.exitArray_declaration(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitArray_declaration"):
                return visitor.visitArray_declaration(self)
            else:
                return visitor.visitChildren(self)

    def array_declaration(self):

        localctx = kqueryParser.Array_declarationContext(
            self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_array_declaration)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 38
            self.match(kqueryParser.T__1)
            self.state = 39
            self.match(kqueryParser.ARRNAME)
            self.state = 40
            self.match(kqueryParser.LSQRBRACKET)
            self.state = 41
            self.match(kqueryParser.SIZE)
            self.state = 42
            self.match(kqueryParser.RSQRBRACKET)
            self.state = 43
            self.match(kqueryParser.COLON)
            self.state = 44
            self.match(kqueryParser.TYPE)
            self.state = 45
            self.match(kqueryParser.ARROW)
            self.state = 46
            self.match(kqueryParser.TYPE)
            self.state = 47
            self.match(kqueryParser.ASSIGN)
            self.state = 48
            self.array_initializer()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Array_initializerContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def LSQRBRACKET(self):
            return self.getToken(kqueryParser.LSQRBRACKET, 0)

        def number_list(self):
            return self.getTypedRuleContext(kqueryParser.Number_listContext, 0)

        def RSQRBRACKET(self):
            return self.getToken(kqueryParser.RSQRBRACKET, 0)

        def getRuleIndex(self):
            return kqueryParser.RULE_array_initializer

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterArray_initializer"):
                listener.enterArray_initializer(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitArray_initializer"):
                listener.exitArray_initializer(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitArray_initializer"):
                return visitor.visitArray_initializer(self)
            else:
                return visitor.visitChildren(self)

    def array_initializer(self):

        localctx = kqueryParser.Array_initializerContext(
            self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_array_initializer)
        try:
            self.state = 55
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [kqueryParser.T__2]:
                self.enterOuterAlt(localctx, 1)
                self.state = 50
                self.match(kqueryParser.T__2)
                pass
            elif token in [kqueryParser.LSQRBRACKET]:
                self.enterOuterAlt(localctx, 2)
                self.state = 51
                self.match(kqueryParser.LSQRBRACKET)
                self.state = 52
                self.number_list()
                self.state = 53
                self.match(kqueryParser.RSQRBRACKET)
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Number_listContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def number(self):
            return self.getTypedRuleContext(kqueryParser.NumberContext, 0)

        def COMMA(self):
            return self.getToken(kqueryParser.COMMA, 0)

        def number_list(self):
            return self.getTypedRuleContext(kqueryParser.Number_listContext, 0)

        def getRuleIndex(self):
            return kqueryParser.RULE_number_list

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterNumber_list"):
                listener.enterNumber_list(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitNumber_list"):
                listener.exitNumber_list(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitNumber_list"):
                return visitor.visitNumber_list(self)
            else:
                return visitor.visitChildren(self)

    def number_list(self):

        localctx = kqueryParser.Number_listContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_number_list)
        try:
            self.state = 62
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input, 3, self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 57
                self.number()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 58
                self.number()
                self.state = 59
                self.match(kqueryParser.COMMA)
                self.state = 60
                self.number_list()
                pass

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class NumberContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def signed_constant(self):
            return self.getTypedRuleContext(kqueryParser.Signed_constantContext, 0)

        def getRuleIndex(self):
            return kqueryParser.RULE_number

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterNumber"):
                listener.enterNumber(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitNumber"):
                listener.exitNumber(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitNumber"):
                return visitor.visitNumber(self)
            else:
                return visitor.visitChildren(self)

    def number(self):

        localctx = kqueryParser.NumberContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_number)
        try:
            self.state = 67
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [kqueryParser.T__3]:
                self.enterOuterAlt(localctx, 1)
                self.state = 64
                self.match(kqueryParser.T__3)
                pass
            elif token in [kqueryParser.T__4]:
                self.enterOuterAlt(localctx, 2)
                self.state = 65
                self.match(kqueryParser.T__4)
                pass
            elif token in [kqueryParser.T__5, kqueryParser.T__6]:
                self.enterOuterAlt(localctx, 3)
                self.state = 66
                self.signed_constant()
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Signed_constantContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def dec_constant(self):
            return self.getTypedRuleContext(kqueryParser.Dec_constantContext, 0)

        def bin_constant(self):
            return self.getTypedRuleContext(kqueryParser.Bin_constantContext, 0)

        def oct_constant(self):
            return self.getTypedRuleContext(kqueryParser.Oct_constantContext, 0)

        def hex_constant(self):
            return self.getTypedRuleContext(kqueryParser.Hex_constantContext, 0)

        def getRuleIndex(self):
            return kqueryParser.RULE_signed_constant

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterSigned_constant"):
                listener.enterSigned_constant(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitSigned_constant"):
                listener.exitSigned_constant(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitSigned_constant"):
                return visitor.visitSigned_constant(self)
            else:
                return visitor.visitChildren(self)

    def signed_constant(self):

        localctx = kqueryParser.Signed_constantContext(
            self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_signed_constant)
        self._la = 0  # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 69
            _la = self._input.LA(1)
            if not(_la == kqueryParser.T__5 or _la == kqueryParser.T__6):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
            self.state = 74
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [kqueryParser.DIGIT]:
                self.state = 70
                self.dec_constant()
                pass
            elif token in [kqueryParser.T__7]:
                self.state = 71
                self.bin_constant()
                pass
            elif token in [kqueryParser.T__10]:
                self.state = 72
                self.oct_constant()
                pass
            elif token in [kqueryParser.T__11]:
                self.state = 73
                self.hex_constant()
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Dec_constantContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def DIGIT(self, i: int = None):
            if i is None:
                return self.getTokens(kqueryParser.DIGIT)
            else:
                return self.getToken(kqueryParser.DIGIT, i)

        def getRuleIndex(self):
            return kqueryParser.RULE_dec_constant

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterDec_constant"):
                listener.enterDec_constant(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitDec_constant"):
                listener.exitDec_constant(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitDec_constant"):
                return visitor.visitDec_constant(self)
            else:
                return visitor.visitChildren(self)

    def dec_constant(self):

        localctx = kqueryParser.Dec_constantContext(
            self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_dec_constant)
        self._la = 0  # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 77
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 76
                self.match(kqueryParser.DIGIT)
                self.state = 79
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la == kqueryParser.DIGIT):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Bin_constantContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def getRuleIndex(self):
            return kqueryParser.RULE_bin_constant

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterBin_constant"):
                listener.enterBin_constant(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitBin_constant"):
                listener.exitBin_constant(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitBin_constant"):
                return visitor.visitBin_constant(self)
            else:
                return visitor.visitChildren(self)

    def bin_constant(self):

        localctx = kqueryParser.Bin_constantContext(
            self, self._ctx, self.state)
        self.enterRule(localctx, 18, self.RULE_bin_constant)
        self._la = 0  # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 81
            self.match(kqueryParser.T__7)
            self.state = 83
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 82
                _la = self._input.LA(1)
                if not(_la == kqueryParser.T__8 or _la == kqueryParser.T__9):
                    self._errHandler.recoverInline(self)
                else:
                    self._errHandler.reportMatch(self)
                    self.consume()
                self.state = 85
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la == kqueryParser.T__8 or _la == kqueryParser.T__9):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Oct_constantContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def OCTAL(self, i: int = None):
            if i is None:
                return self.getTokens(kqueryParser.OCTAL)
            else:
                return self.getToken(kqueryParser.OCTAL, i)

        def getRuleIndex(self):
            return kqueryParser.RULE_oct_constant

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterOct_constant"):
                listener.enterOct_constant(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitOct_constant"):
                listener.exitOct_constant(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitOct_constant"):
                return visitor.visitOct_constant(self)
            else:
                return visitor.visitChildren(self)

    def oct_constant(self):

        localctx = kqueryParser.Oct_constantContext(
            self, self._ctx, self.state)
        self.enterRule(localctx, 20, self.RULE_oct_constant)
        self._la = 0  # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 87
            self.match(kqueryParser.T__10)
            self.state = 89
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 88
                self.match(kqueryParser.OCTAL)
                self.state = 91
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la == kqueryParser.OCTAL):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx

    class Hex_constantContext(ParserRuleContext):

        def __init__(self, parser, parent: ParserRuleContext = None, invokingState: int = -1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def HEX(self, i: int = None):
            if i is None:
                return self.getTokens(kqueryParser.HEX)
            else:
                return self.getToken(kqueryParser.HEX, i)

        def getRuleIndex(self):
            return kqueryParser.RULE_hex_constant

        def enterRule(self, listener: ParseTreeListener):
            if hasattr(listener, "enterHex_constant"):
                listener.enterHex_constant(self)

        def exitRule(self, listener: ParseTreeListener):
            if hasattr(listener, "exitHex_constant"):
                listener.exitHex_constant(self)

        def accept(self, visitor: ParseTreeVisitor):
            if hasattr(visitor, "visitHex_constant"):
                return visitor.visitHex_constant(self)
            else:
                return visitor.visitChildren(self)

    def hex_constant(self):

        localctx = kqueryParser.Hex_constantContext(
            self, self._ctx, self.state)
        self.enterRule(localctx, 22, self.RULE_hex_constant)
        self._la = 0  # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 93
            self.match(kqueryParser.T__11)
            self.state = 95
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 94
                self.match(kqueryParser.HEX)
                self.state = 97
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la == kqueryParser.HEX):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx
