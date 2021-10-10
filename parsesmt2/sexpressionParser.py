# Generated from sexpression.g4 by ANTLR 4.7.2
# encoding: utf-8
from antlr4 import *
from io import StringIO
from typing.io import TextIO
import sys


def serializedATN():
    with StringIO() as buf:
        buf.write("\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\t")
        buf.write("(\4\2\t\2\4\3\t\3\4\4\t\4\4\5\t\5\3\2\7\2\f\n\2\f\2\16")
        buf.write("\2\17\13\2\3\2\3\2\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\5\3")
        buf.write("\33\n\3\3\4\3\4\7\4\37\n\4\f\4\16\4\"\13\4\3\4\3\4\3\5")
        buf.write("\3\5\3\5\2\2\6\2\4\6\b\2\3\5\2\3\3\5\6\t\t\2\'\2\r\3\2")
        buf.write("\2\2\4\32\3\2\2\2\6\34\3\2\2\2\b%\3\2\2\2\n\f\5\4\3\2")
        buf.write("\13\n\3\2\2\2\f\17\3\2\2\2\r\13\3\2\2\2\r\16\3\2\2\2\16")
        buf.write("\20\3\2\2\2\17\r\3\2\2\2\20\21\7\2\2\3\21\3\3\2\2\2\22")
        buf.write("\33\5\b\5\2\23\33\5\6\4\2\24\25\7\7\2\2\25\26\5\4\3\2")
        buf.write("\26\27\7\t\2\2\27\30\5\4\3\2\30\31\7\b\2\2\31\33\3\2\2")
        buf.write("\2\32\22\3\2\2\2\32\23\3\2\2\2\32\24\3\2\2\2\33\5\3\2")
        buf.write("\2\2\34 \7\7\2\2\35\37\5\4\3\2\36\35\3\2\2\2\37\"\3\2")
        buf.write("\2\2 \36\3\2\2\2 !\3\2\2\2!#\3\2\2\2\" \3\2\2\2#$\7\b")
        buf.write("\2\2$\7\3\2\2\2%&\t\2\2\2&\t\3\2\2\2\5\r\32 ")
        return buf.getvalue()


class sexpressionParser ( Parser ):

    grammarFileName = "sexpression.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "<INVALID>", "'('", "')'", "'.'" ]

    symbolicNames = [ "<INVALID>", "STRING", "WHITESPACE", "NUMBER", "SYMBOL", 
                      "LPAREN", "RPAREN", "DOT" ]

    RULE_sexpr = 0
    RULE_item = 1
    RULE_list_ = 2
    RULE_atom = 3

    ruleNames =  [ "sexpr", "item", "list_", "atom" ]

    EOF = Token.EOF
    STRING=1
    WHITESPACE=2
    NUMBER=3
    SYMBOL=4
    LPAREN=5
    RPAREN=6
    DOT=7

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.7.2")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None




    class SexprContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def EOF(self):
            return self.getToken(sexpressionParser.EOF, 0)

        def item(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(sexpressionParser.ItemContext)
            else:
                return self.getTypedRuleContext(sexpressionParser.ItemContext,i)


        def getRuleIndex(self):
            return sexpressionParser.RULE_sexpr

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSexpr" ):
                return visitor.visitSexpr(self)
            else:
                return visitor.visitChildren(self)




    def sexpr(self):

        localctx = sexpressionParser.SexprContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_sexpr)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 11
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << sexpressionParser.STRING) | (1 << sexpressionParser.NUMBER) | (1 << sexpressionParser.SYMBOL) | (1 << sexpressionParser.LPAREN) | (1 << sexpressionParser.DOT))) != 0):
                self.state = 8
                self.item()
                self.state = 13
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 14
            self.match(sexpressionParser.EOF)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ItemContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def atom(self):
            return self.getTypedRuleContext(sexpressionParser.AtomContext,0)


        def list_(self):
            return self.getTypedRuleContext(sexpressionParser.List_Context,0)


        def LPAREN(self):
            return self.getToken(sexpressionParser.LPAREN, 0)

        def item(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(sexpressionParser.ItemContext)
            else:
                return self.getTypedRuleContext(sexpressionParser.ItemContext,i)


        def DOT(self):
            return self.getToken(sexpressionParser.DOT, 0)

        def RPAREN(self):
            return self.getToken(sexpressionParser.RPAREN, 0)

        def getRuleIndex(self):
            return sexpressionParser.RULE_item

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitItem" ):
                return visitor.visitItem(self)
            else:
                return visitor.visitChildren(self)




    def item(self):

        localctx = sexpressionParser.ItemContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_item)
        try:
            self.state = 24
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,1,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 16
                self.atom()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 17
                self.list_()
                pass

            elif la_ == 3:
                self.enterOuterAlt(localctx, 3)
                self.state = 18
                self.match(sexpressionParser.LPAREN)
                self.state = 19
                self.item()
                self.state = 20
                self.match(sexpressionParser.DOT)
                self.state = 21
                self.item()
                self.state = 22
                self.match(sexpressionParser.RPAREN)
                pass


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class List_Context(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def LPAREN(self):
            return self.getToken(sexpressionParser.LPAREN, 0)

        def RPAREN(self):
            return self.getToken(sexpressionParser.RPAREN, 0)

        def item(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(sexpressionParser.ItemContext)
            else:
                return self.getTypedRuleContext(sexpressionParser.ItemContext,i)


        def getRuleIndex(self):
            return sexpressionParser.RULE_list_

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitList_" ):
                return visitor.visitList_(self)
            else:
                return visitor.visitChildren(self)




    def list_(self):

        localctx = sexpressionParser.List_Context(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_list_)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 26
            self.match(sexpressionParser.LPAREN)
            self.state = 30
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while (((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << sexpressionParser.STRING) | (1 << sexpressionParser.NUMBER) | (1 << sexpressionParser.SYMBOL) | (1 << sexpressionParser.LPAREN) | (1 << sexpressionParser.DOT))) != 0):
                self.state = 27
                self.item()
                self.state = 32
                self._errHandler.sync(self)
                _la = self._input.LA(1)

            self.state = 33
            self.match(sexpressionParser.RPAREN)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class AtomContext(ParserRuleContext):

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def STRING(self):
            return self.getToken(sexpressionParser.STRING, 0)

        def SYMBOL(self):
            return self.getToken(sexpressionParser.SYMBOL, 0)

        def NUMBER(self):
            return self.getToken(sexpressionParser.NUMBER, 0)

        def DOT(self):
            return self.getToken(sexpressionParser.DOT, 0)

        def getRuleIndex(self):
            return sexpressionParser.RULE_atom

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitAtom" ):
                return visitor.visitAtom(self)
            else:
                return visitor.visitChildren(self)




    def atom(self):

        localctx = sexpressionParser.AtomContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_atom)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 35
            _la = self._input.LA(1)
            if not((((_la) & ~0x3f) == 0 and ((1 << _la) & ((1 << sexpressionParser.STRING) | (1 << sexpressionParser.NUMBER) | (1 << sexpressionParser.SYMBOL) | (1 << sexpressionParser.DOT))) != 0)):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx





