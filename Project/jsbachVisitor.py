# Generated from jsbach.g4 by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .jsbachParser import jsbachParser
else:
    from jsbachParser import jsbachParser

# This class defines a complete generic visitor for a parse tree produced by jsbachParser.

class jsbachVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by jsbachParser#program.
    def visitProgram(self, ctx:jsbachParser.ProgramContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#function.
    def visitFunction(self, ctx:jsbachParser.FunctionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#parameters.
    def visitParameters(self, ctx:jsbachParser.ParametersContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Assign.
    def visitAssign(self, ctx:jsbachParser.AssignContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#If.
    def visitIf(self, ctx:jsbachParser.IfContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#IfElse.
    def visitIfElse(self, ctx:jsbachParser.IfElseContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#While.
    def visitWhile(self, ctx:jsbachParser.WhileContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Call.
    def visitCall(self, ctx:jsbachParser.CallContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Read.
    def visitRead(self, ctx:jsbachParser.ReadContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Write.
    def visitWrite(self, ctx:jsbachParser.WriteContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Play.
    def visitPlay(self, ctx:jsbachParser.PlayContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Trim.
    def visitTrim(self, ctx:jsbachParser.TrimContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Add.
    def visitAdd(self, ctx:jsbachParser.AddContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#statements.
    def visitStatements(self, ctx:jsbachParser.StatementsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#list_note.
    def visitList_note(self, ctx:jsbachParser.List_noteContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Parenths.
    def visitParenths(self, ctx:jsbachParser.ParenthsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#NoteList.
    def visitNoteList(self, ctx:jsbachParser.NoteListContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Length.
    def visitLength(self, ctx:jsbachParser.LengthContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Var.
    def visitVar(self, ctx:jsbachParser.VarContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#ListAccess.
    def visitListAccess(self, ctx:jsbachParser.ListAccessContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Note.
    def visitNote(self, ctx:jsbachParser.NoteContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Value.
    def visitValue(self, ctx:jsbachParser.ValueContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Relational.
    def visitRelational(self, ctx:jsbachParser.RelationalContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#String.
    def visitString(self, ctx:jsbachParser.StringContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#Arithmetic.
    def visitArithmetic(self, ctx:jsbachParser.ArithmeticContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by jsbachParser#list_expr.
    def visitList_expr(self, ctx:jsbachParser.List_exprContext):
        return self.visitChildren(ctx)



del jsbachParser