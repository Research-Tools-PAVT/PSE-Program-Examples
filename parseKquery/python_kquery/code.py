import sys
from antlr4 import *
from kqueryParser import kqueryParser
from kqueryListener import kqueryListener
from kqueryLexer import kqueryLexer
from kqueryVisitor import kqueryVisitor


def main(argv):
    while True:
        text = InputStream(input(">"))
        lexer = kqueryLexer(text)
        stream = CommonTokenStream(lexer)
        parser = kqueryParser(stream)
        tree = parser.kquery()
        ast = kqueryVisitor().visitKquery(tree)
        print('=', ast)


if __name__ == '__main__':
    main(sys.argv)
