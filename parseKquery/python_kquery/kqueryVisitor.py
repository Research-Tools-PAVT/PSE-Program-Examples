# Generated from kquery.g4 by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kqueryParser import kqueryParser
else:
    from kqueryParser import kqueryParser

# This class defines a complete generic visitor for a parse tree produced by kqueryParser.

class kqueryVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by kqueryParser#kquery.
    def visitKquery(self, ctx:kqueryParser.KqueryContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#query_command.
    def visitQuery_command(self, ctx:kqueryParser.Query_commandContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#array_declaration.
    def visitArray_declaration(self, ctx:kqueryParser.Array_declarationContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#array_initializer.
    def visitArray_initializer(self, ctx:kqueryParser.Array_initializerContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#number_list.
    def visitNumber_list(self, ctx:kqueryParser.Number_listContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#number.
    def visitNumber(self, ctx:kqueryParser.NumberContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#signed_constant.
    def visitSigned_constant(self, ctx:kqueryParser.Signed_constantContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#dec_constant.
    def visitDec_constant(self, ctx:kqueryParser.Dec_constantContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#bin_constant.
    def visitBin_constant(self, ctx:kqueryParser.Bin_constantContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#oct_constant.
    def visitOct_constant(self, ctx:kqueryParser.Oct_constantContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kqueryParser#hex_constant.
    def visitHex_constant(self, ctx:kqueryParser.Hex_constantContext):
        return self.visitChildren(ctx)



del kqueryParser