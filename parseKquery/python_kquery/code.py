import sys
from antlr4 import *
from kqueryParser import kqueryParser
from kqueryListener import kqueryListener
from kqueryLexer import kqueryLexer
from kqueryVisitor import kqueryVisitor


class kqueryPPrinter(kqueryVisitor):
    def __init__(self):
        pass

    # Visit a parse tree produced by kqueryParser#kqueryStart.
    def visitorCode(self, ctx: kqueryParser.KqueryStartContext):
        kqueryList = self.visit(ctx.kquery())
        return kqueryList


def main(argv):
    while True:
        text = InputStream(input(">"))
        lexer = kqueryLexer(text)
        stream = CommonTokenStream(lexer)
        parser = kqueryParser(stream)
        tree = parser.kqueryStart()
        ast = kqueryVisitor().visitKqueryStart(tree)
        print('=', tree, ast)


if __name__ == '__main__':
    main(sys.argv)
