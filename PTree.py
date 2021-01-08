# -*- coding: utf-8 -*-
from graphviz import Source, Graph, Digraph


def format_stmts(node):
    return "\n".join([str(elems) for elems in node.data])


class ExecutionTreeNode:
    def __init__(self, content, id):
        self.left = None
        self.right = None
        self.type = None
        self.parent = None
        self.added = False
        self.id = id
        self.data = []
        self.edges = []
        self.data.append(content)


class ExecutionTreeEdge:
    def __init__(self, parent, child, label="execution", color="black"):
        self.parent = parent
        self.child = child
        child.parent = parent
        self.label = label
        self.color = color
        self.graph = Digraph(comment="Execution Edge", format="png")

    def view_edge(self):
        """
        Just show the edge i.e Parent --> Child
        """
        self.graph.edge(
            format_stmts(self.parent),
            format_stmts(self.child),
            color=self.color,
            label=self.label,
        )
        self.graph.render()


class ExecutionTree:
    def __init__(self, nodes=[]):
        self.nodes = nodes
        self.counter = 0

    def save_cfg(self, name="sample", filename="sample", directory="."):
        graph = Digraph(name=name,
                        filename=filename,
                        directory=directory,
                        format="png")
        for node in self.nodes:
            for edge in node.edges:
                graph.edge(
                    format_stmts(edge.parent),
                    format_stmts(edge.child),
                    color=edge.color,
                    label=edge.label,
                )
        graph.render()

    def add_node(self, node):
        if not node.added:
            self.counter += 1
            node.added = True
            node.uid = self.counter
            self.nodes.append(node)


if __name__ == "__main__":
    print("Building Execution Tree")
    Tree = ExecutionTree()
    root = ExecutionTreeNode("Root", 0)
    arr = [1, 2]
    for index, elems in enumerate(arr):
        if index < len(arr) / 2:
            node = ExecutionTreeNode(index, index)
            left = ExecutionTreeNode(2 * index + 1, 2 * index + 1)
            right = ExecutionTreeNode(2 * index + 2, 2 * index + 2)
            Tree.add_node(node)
            Tree.add_node(left)
            Tree.add_node(right)
            trueExpr = "True"
            falseExpr = "False"
            node.edges.append(
                ExecutionTreeEdge(node,
                                  left,
                                  label=' '.join(trueExpr.split()),
                                  color="green"))
            node.edges.append(
                ExecutionTreeEdge(node,
                                  right,
                                  label=' '.join(falseExpr.split()),
                                  color="Red"))
        else:
            pass

    Tree.save_cfg()