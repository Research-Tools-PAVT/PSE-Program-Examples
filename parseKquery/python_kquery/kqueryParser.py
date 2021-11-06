# Generated from kquery.g4 by ANTLR 4.7.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3%")
        buf.write("_\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b")
        buf.write("\t\b\4\t\t\t\4\n\t\n\4\13\t\13\4\f\t\f\3\2\3\2\3\2\3\2")
        buf.write("\5\2\35\n\2\3\3\3\3\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3")
        buf.write("\4\3\4\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\5\5\63\n\5\3\6")
        buf.write("\3\6\3\6\3\6\3\6\5\6:\n\6\3\7\3\7\3\7\5\7?\n\7\3\b\3\b")
        buf.write("\3\b\3\b\3\b\5\bF\n\b\3\t\6\tI\n\t\r\t\16\tJ\3\n\3\n\6")
        buf.write("\nO\n\n\r\n\16\nP\3\13\3\13\6\13U\n\13\r\13\16\13V\3\f")
        buf.write("\3\f\6\f[\n\f\r\f\16\f\\\3\f\2\2\r\2\4\6\b\n\f\16\20\22")
        buf.write("\24\26\2\4\4\2\b\b\17\17\3\2\21\22\2_\2\34\3\2\2\2\4\36")
        buf.write("\3\2\2\2\6 \3\2\2\2\b\62\3\2\2\2\n9\3\2\2\2\f>\3\2\2\2")
        buf.write("\16@\3\2\2\2\20H\3\2\2\2\22L\3\2\2\2\24R\3\2\2\2\26X\3")
        buf.write("\2\2\2\30\35\5\6\4\2\31\32\5\4\3\2\32\33\7\2\2\3\33\35")
        buf.write("\3\2\2\2\34\30\3\2\2\2\34\31\3\2\2\2\35\3\3\2\2\2\36\37")
        buf.write("\7\3\2\2\37\5\3\2\2\2 !\7\4\2\2!\"\7\31\2\2\"#\7\5\2\2")
        buf.write("#$\7\27\2\2$%\7\6\2\2%&\7\7\2\2&\'\7\25\2\2\'(\7\b\2\2")
        buf.write("()\7\t\2\2)*\7\26\2\2*+\7\n\2\2+,\5\b\5\2,\7\3\2\2\2-")
        buf.write("\63\7\13\2\2./\7\5\2\2/\60\5\n\6\2\60\61\7\6\2\2\61\63")
        buf.write("\3\2\2\2\62-\3\2\2\2\62.\3\2\2\2\63\t\3\2\2\2\64:\5\f")
        buf.write("\7\2\65\66\5\f\7\2\66\67\7\f\2\2\678\5\n\6\28:\3\2\2\2")
        buf.write("9\64\3\2\2\29\65\3\2\2\2:\13\3\2\2\2;?\7\r\2\2<?\7\16")
        buf.write("\2\2=?\5\16\b\2>;\3\2\2\2><\3\2\2\2>=\3\2\2\2?\r\3\2\2")
        buf.write("\2@E\t\2\2\2AF\5\20\t\2BF\5\22\n\2CF\5\24\13\2DF\5\26")
        buf.write("\f\2EA\3\2\2\2EB\3\2\2\2EC\3\2\2\2ED\3\2\2\2F\17\3\2\2")
        buf.write("\2GI\7#\2\2HG\3\2\2\2IJ\3\2\2\2JH\3\2\2\2JK\3\2\2\2K\21")
        buf.write("\3\2\2\2LN\7\20\2\2MO\t\3\2\2NM\3\2\2\2OP\3\2\2\2PN\3")
        buf.write("\2\2\2PQ\3\2\2\2Q\23\3\2\2\2RT\7\23\2\2SU\7$\2\2TS\3\2")
        buf.write("\2\2UV\3\2\2\2VT\3\2\2\2VW\3\2\2\2W\25\3\2\2\2XZ\7\24")
        buf.write("\2\2Y[\7%\2\2ZY\3\2\2\2[\\\3\2\2\2\\Z\3\2\2\2\\]\3\2\2")
        buf.write("\2]\27\3\2\2\2\13\34\629>EJPV\\")
        return buf.getvalue()


class kqueryParser ( Parser ):

    grammarFileName = "kquery.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "'query'", "'array'", "'['", "']'", "':'", 
                     "'-'", "'>'", "'='", "'symbolic'", "','", "'true'", 
                     "'false'", "'+'", "'0b'", "'0'", "'1'", "'0o'", "'0x'", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "<INVALID>", "'('", "')'", "'w'", "'.'" ]

    symbolicNames = [ "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                      "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                      "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                      "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                      "<INVALID>", "<INVALID>", "<INVALID>", "DOMAIN", "RANGE", 
                      "SIZE", "TYPE", "ARRNAME", "IDENTIFIER", "STRING", 
                      "WHITESPACE", "NUMBER", "SYMBOL", "LPAREN", "RPAREN", 
                      "WIDTH", "DOT", "DIGIT", "OCTAL", "HEX" ]

    RULE_kquery = 0
    RULE_query_command = 1
    RULE_array_declaration = 2
    RULE_array_initializer = 3
    RULE_number_list = 4
    RULE_number = 5
    RULE_signed_constant = 6
    RULE_dec_constant = 7
    RULE_bin_constant = 8
    RULE_oct_constant = 9
    RULE_hex_constant = 10

    ruleNames =  [ "kquery", "query_command", "array_declaration", "array_initializer", 
                   "number_list", "number", "signed_constant", "dec_constant", 
                   "bin_constant", "oct_constant", "hex_constant" ]

    EOF = Token.EOF
    T__0=1
    T__1=2
    T__2=3
    T__3=4
    T__4=5
    T__5=6
    T__6=7
    T__7=8
    T__8=9
    T__9=10
    T__10=11
    T__11=12
    T__12=13
    T__13=14
    T__14=15
    T__15=16
    T__16=17
    T__17=18
    DOMAIN=19
    RANGE=20
    SIZE=21
    TYPE=22
    ARRNAME=23
    IDENTIFIER=24
    STRING=25
    WHITESPACE=26
    NUMBER=27
    SYMBOL=28
    LPAREN=29
    RPAREN=30
    WIDTH=31
    DOT=32
    DIGIT=33
    OCTAL=34
    HEX=35

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7.2")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None




    class KqueryContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def array_declaration(self):
            return self.getTypedRuleContext(kqueryParser.Array_declarationContext,0)


        def query_command(self):
            return self.getTypedRuleContext(kqueryParser.Query_commandContext,0)


        def EOF(self):
            return self.getToken(kqueryParser.EOF, 0)

        def getRuleIndex(self):
            return kqueryParser.RULE_kquery

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterKquery" ):
                listener.enterKquery(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitKquery" ):
                listener.exitKquery(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitKquery" ):
                return visitor.visitKquery(self)
            else:
                return visitor.visitChildren(self)




    def kquery(self):

        localctx = kqueryParser.KqueryContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_kquery)
        try:
            self.state = 26
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [kqueryParser.T__1]:
                self.enterOuterAlt(localctx, 1)
                self.state = 22
                self.array_declaration()
                pass
            elif token in [kqueryParser.T__0]:
                self.enterOuterAlt(localctx, 2)
                self.state = 23
                self.query_command()
                self.state = 24
                self.match(kqueryParser.EOF)
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

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return kqueryParser.RULE_query_command

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterQuery_command" ):
                listener.enterQuery_command(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitQuery_command" ):
                listener.exitQuery_command(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitQuery_command" ):
                return visitor.visitQuery_command(self)
            else:
                return visitor.visitChildren(self)




    def query_command(self):

        localctx = kqueryParser.Query_commandContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_query_command)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 28
            self.match(kqueryParser.T__0)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Array_declarationContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def ARRNAME(self):
            return self.getToken(kqueryParser.ARRNAME, 0)

        def SIZE(self):
            return self.getToken(kqueryParser.SIZE, 0)

        def DOMAIN(self):
            return self.getToken(kqueryParser.DOMAIN, 0)

        def RANGE(self):
            return self.getToken(kqueryParser.RANGE, 0)

        def array_initializer(self):
            return self.getTypedRuleContext(kqueryParser.Array_initializerContext,0)


        def getRuleIndex(self):
            return kqueryParser.RULE_array_declaration

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterArray_declaration" ):
                listener.enterArray_declaration(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitArray_declaration" ):
                listener.exitArray_declaration(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitArray_declaration" ):
                return visitor.visitArray_declaration(self)
            else:
                return visitor.visitChildren(self)




    def array_declaration(self):

        localctx = kqueryParser.Array_declarationContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_array_declaration)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 30
            self.match(kqueryParser.T__1)
            self.state = 31
            self.match(kqueryParser.ARRNAME)
            self.state = 32
            self.match(kqueryParser.T__2)
            self.state = 33
            self.match(kqueryParser.SIZE)
            self.state = 34
            self.match(kqueryParser.T__3)
            self.state = 35
            self.match(kqueryParser.T__4)
            self.state = 36
            self.match(kqueryParser.DOMAIN)
            self.state = 37
            self.match(kqueryParser.T__5)
            self.state = 38
            self.match(kqueryParser.T__6)
            self.state = 39
            self.match(kqueryParser.RANGE)
            self.state = 40
            self.match(kqueryParser.T__7)
            self.state = 41
            self.array_initializer()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Array_initializerContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def number_list(self):
            return self.getTypedRuleContext(kqueryParser.Number_listContext,0)


        def getRuleIndex(self):
            return kqueryParser.RULE_array_initializer

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterArray_initializer" ):
                listener.enterArray_initializer(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitArray_initializer" ):
                listener.exitArray_initializer(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitArray_initializer" ):
                return visitor.visitArray_initializer(self)
            else:
                return visitor.visitChildren(self)




    def array_initializer(self):

        localctx = kqueryParser.Array_initializerContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_array_initializer)
        try:
            self.state = 48
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [kqueryParser.T__8]:
                self.enterOuterAlt(localctx, 1)
                self.state = 43
                self.match(kqueryParser.T__8)
                pass
            elif token in [kqueryParser.T__2]:
                self.enterOuterAlt(localctx, 2)
                self.state = 44
                self.match(kqueryParser.T__2)
                self.state = 45
                self.number_list()
                self.state = 46
                self.match(kqueryParser.T__3)
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

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def number(self):
            return self.getTypedRuleContext(kqueryParser.NumberContext,0)


        def number_list(self):
            return self.getTypedRuleContext(kqueryParser.Number_listContext,0)


        def getRuleIndex(self):
            return kqueryParser.RULE_number_list

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterNumber_list" ):
                listener.enterNumber_list(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitNumber_list" ):
                listener.exitNumber_list(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitNumber_list" ):
                return visitor.visitNumber_list(self)
            else:
                return visitor.visitChildren(self)




    def number_list(self):

        localctx = kqueryParser.Number_listContext(self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_number_list)
        try:
            self.state = 55
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,2,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 50
                self.number()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 51
                self.number()
                self.state = 52
                self.match(kqueryParser.T__9)
                self.state = 53
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

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def signed_constant(self):
            return self.getTypedRuleContext(kqueryParser.Signed_constantContext,0)


        def getRuleIndex(self):
            return kqueryParser.RULE_number

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterNumber" ):
                listener.enterNumber(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitNumber" ):
                listener.exitNumber(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitNumber" ):
                return visitor.visitNumber(self)
            else:
                return visitor.visitChildren(self)




    def number(self):

        localctx = kqueryParser.NumberContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_number)
        try:
            self.state = 60
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [kqueryParser.T__10]:
                self.enterOuterAlt(localctx, 1)
                self.state = 57
                self.match(kqueryParser.T__10)
                pass
            elif token in [kqueryParser.T__11]:
                self.enterOuterAlt(localctx, 2)
                self.state = 58
                self.match(kqueryParser.T__11)
                pass
            elif token in [kqueryParser.T__5, kqueryParser.T__12]:
                self.enterOuterAlt(localctx, 3)
                self.state = 59
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

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def dec_constant(self):
            return self.getTypedRuleContext(kqueryParser.Dec_constantContext,0)


        def bin_constant(self):
            return self.getTypedRuleContext(kqueryParser.Bin_constantContext,0)


        def oct_constant(self):
            return self.getTypedRuleContext(kqueryParser.Oct_constantContext,0)


        def hex_constant(self):
            return self.getTypedRuleContext(kqueryParser.Hex_constantContext,0)


        def getRuleIndex(self):
            return kqueryParser.RULE_signed_constant

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSigned_constant" ):
                listener.enterSigned_constant(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSigned_constant" ):
                listener.exitSigned_constant(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSigned_constant" ):
                return visitor.visitSigned_constant(self)
            else:
                return visitor.visitChildren(self)




    def signed_constant(self):

        localctx = kqueryParser.Signed_constantContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_signed_constant)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 62
            _la = self._input.LA(1)
            if not(_la==kqueryParser.T__5 or _la==kqueryParser.T__12):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
            self.state = 67
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [kqueryParser.DIGIT]:
                self.state = 63
                self.dec_constant()
                pass
            elif token in [kqueryParser.T__13]:
                self.state = 64
                self.bin_constant()
                pass
            elif token in [kqueryParser.T__16]:
                self.state = 65
                self.oct_constant()
                pass
            elif token in [kqueryParser.T__17]:
                self.state = 66
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

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def DIGIT(self, i:int=None):
            if i is None:
                return self.getTokens(kqueryParser.DIGIT)
            else:
                return self.getToken(kqueryParser.DIGIT, i)

        def getRuleIndex(self):
            return kqueryParser.RULE_dec_constant

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterDec_constant" ):
                listener.enterDec_constant(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitDec_constant" ):
                listener.exitDec_constant(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitDec_constant" ):
                return visitor.visitDec_constant(self)
            else:
                return visitor.visitChildren(self)




    def dec_constant(self):

        localctx = kqueryParser.Dec_constantContext(self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_dec_constant)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 70 
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 69
                self.match(kqueryParser.DIGIT)
                self.state = 72 
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la==kqueryParser.DIGIT):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Bin_constantContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return kqueryParser.RULE_bin_constant

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterBin_constant" ):
                listener.enterBin_constant(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitBin_constant" ):
                listener.exitBin_constant(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitBin_constant" ):
                return visitor.visitBin_constant(self)
            else:
                return visitor.visitChildren(self)




    def bin_constant(self):

        localctx = kqueryParser.Bin_constantContext(self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_bin_constant)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 74
            self.match(kqueryParser.T__13)
            self.state = 76 
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 75
                _la = self._input.LA(1)
                if not(_la==kqueryParser.T__14 or _la==kqueryParser.T__15):
                    self._errHandler.recoverInline(self)
                else:
                    self._errHandler.reportMatch(self)
                    self.consume()
                self.state = 78 
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la==kqueryParser.T__14 or _la==kqueryParser.T__15):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Oct_constantContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def OCTAL(self, i:int=None):
            if i is None:
                return self.getTokens(kqueryParser.OCTAL)
            else:
                return self.getToken(kqueryParser.OCTAL, i)

        def getRuleIndex(self):
            return kqueryParser.RULE_oct_constant

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterOct_constant" ):
                listener.enterOct_constant(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitOct_constant" ):
                listener.exitOct_constant(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitOct_constant" ):
                return visitor.visitOct_constant(self)
            else:
                return visitor.visitChildren(self)




    def oct_constant(self):

        localctx = kqueryParser.Oct_constantContext(self, self._ctx, self.state)
        self.enterRule(localctx, 18, self.RULE_oct_constant)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 80
            self.match(kqueryParser.T__16)
            self.state = 82 
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 81
                self.match(kqueryParser.OCTAL)
                self.state = 84 
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la==kqueryParser.OCTAL):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Hex_constantContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def HEX(self, i:int=None):
            if i is None:
                return self.getTokens(kqueryParser.HEX)
            else:
                return self.getToken(kqueryParser.HEX, i)

        def getRuleIndex(self):
            return kqueryParser.RULE_hex_constant

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterHex_constant" ):
                listener.enterHex_constant(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitHex_constant" ):
                listener.exitHex_constant(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitHex_constant" ):
                return visitor.visitHex_constant(self)
            else:
                return visitor.visitChildren(self)




    def hex_constant(self):

        localctx = kqueryParser.Hex_constantContext(self, self._ctx, self.state)
        self.enterRule(localctx, 20, self.RULE_hex_constant)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 86
            self.match(kqueryParser.T__17)
            self.state = 88 
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 87
                self.match(kqueryParser.HEX)
                self.state = 90 
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not (_la==kqueryParser.HEX):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx





