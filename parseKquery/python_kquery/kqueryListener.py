# Generated from kquery.g4 by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kqueryParser import kqueryParser
else:
    from kqueryParser import kqueryParser

# This class defines a complete listener for a parse tree produced by kqueryParser.
class kqueryListener(ParseTreeListener):

    # Enter a parse tree produced by kqueryParser#kqueryStart.
    def enterKqueryStart(self, ctx:kqueryParser.KqueryStartContext):
        pass

    # Exit a parse tree produced by kqueryParser#kqueryStart.
    def exitKqueryStart(self, ctx:kqueryParser.KqueryStartContext):
        pass


    # Enter a parse tree produced by kqueryParser#kquery.
    def enterKquery(self, ctx:kqueryParser.KqueryContext):
        pass

    # Exit a parse tree produced by kqueryParser#kquery.
    def exitKquery(self, ctx:kqueryParser.KqueryContext):
        pass


    # Enter a parse tree produced by kqueryParser#query_command.
    def enterQuery_command(self, ctx:kqueryParser.Query_commandContext):
        pass

    # Exit a parse tree produced by kqueryParser#query_command.
    def exitQuery_command(self, ctx:kqueryParser.Query_commandContext):
        pass


    # Enter a parse tree produced by kqueryParser#array_declaration.
    def enterArray_declaration(self, ctx:kqueryParser.Array_declarationContext):
        pass

    # Exit a parse tree produced by kqueryParser#array_declaration.
    def exitArray_declaration(self, ctx:kqueryParser.Array_declarationContext):
        pass


    # Enter a parse tree produced by kqueryParser#array_initializer.
    def enterArray_initializer(self, ctx:kqueryParser.Array_initializerContext):
        pass

    # Exit a parse tree produced by kqueryParser#array_initializer.
    def exitArray_initializer(self, ctx:kqueryParser.Array_initializerContext):
        pass


    # Enter a parse tree produced by kqueryParser#number_list.
    def enterNumber_list(self, ctx:kqueryParser.Number_listContext):
        pass

    # Exit a parse tree produced by kqueryParser#number_list.
    def exitNumber_list(self, ctx:kqueryParser.Number_listContext):
        pass


    # Enter a parse tree produced by kqueryParser#number.
    def enterNumber(self, ctx:kqueryParser.NumberContext):
        pass

    # Exit a parse tree produced by kqueryParser#number.
    def exitNumber(self, ctx:kqueryParser.NumberContext):
        pass


    # Enter a parse tree produced by kqueryParser#signed_constant.
    def enterSigned_constant(self, ctx:kqueryParser.Signed_constantContext):
        pass

    # Exit a parse tree produced by kqueryParser#signed_constant.
    def exitSigned_constant(self, ctx:kqueryParser.Signed_constantContext):
        pass


    # Enter a parse tree produced by kqueryParser#dec_constant.
    def enterDec_constant(self, ctx:kqueryParser.Dec_constantContext):
        pass

    # Exit a parse tree produced by kqueryParser#dec_constant.
    def exitDec_constant(self, ctx:kqueryParser.Dec_constantContext):
        pass


    # Enter a parse tree produced by kqueryParser#bin_constant.
    def enterBin_constant(self, ctx:kqueryParser.Bin_constantContext):
        pass

    # Exit a parse tree produced by kqueryParser#bin_constant.
    def exitBin_constant(self, ctx:kqueryParser.Bin_constantContext):
        pass


    # Enter a parse tree produced by kqueryParser#oct_constant.
    def enterOct_constant(self, ctx:kqueryParser.Oct_constantContext):
        pass

    # Exit a parse tree produced by kqueryParser#oct_constant.
    def exitOct_constant(self, ctx:kqueryParser.Oct_constantContext):
        pass


    # Enter a parse tree produced by kqueryParser#hex_constant.
    def enterHex_constant(self, ctx:kqueryParser.Hex_constantContext):
        pass

    # Exit a parse tree produced by kqueryParser#hex_constant.
    def exitHex_constant(self, ctx:kqueryParser.Hex_constantContext):
        pass


