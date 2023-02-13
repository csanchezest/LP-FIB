import sys
import os
from antlr4 import *
from jsbachLexer import jsbachLexer
from jsbachParser import jsbachParser
# from TreeVisitor import TreeVisitor
if __name__ is not None and "." in __name__:
    from .jsbachParser import jsbachParser
    from .jsbachVisitor import jsbachVisitor
else:
    from jsbachParser import jsbachParser
    from jsbachVisitor import jsbachVisitor


class EvalVisitor(jsbachVisitor):

    def __init__(self, main, filename):
        self.context = []   # pila de diccionaris per nivell (0: main)
        self.funs = {}  # tupla (IdFuncio, llistaParametres, codi)
        self.nivell = 0  # mecanisme de scope
        self.main = main  # mecanisme per coneixer el nom del main del programa
        self.int_to_note = ['a\'0', 'b\'0', 'c\'1', 'd\'1', 'e\'1', 'f\'1', 'g\'1',
                            'a\'1', 'b\'1', 'c\'2', 'd\'2', 'e\'2', 'f\'2', 'g\'2',
                            'a\'2', 'b\'2', 'c\'3', 'd\'3', 'e\'3', 'f\'3', 'g\'3',
                            'a\'3', 'b\'3', 'c\'4', 'd\'4', 'e\'4', 'f\'4', 'g\'4',
                            'a\'4', 'b\'4', 'c\'5', 'd\'5', 'e\'5', 'f\'5', 'g\'5',
                            'a\'5', 'b\'5', 'c\'6', 'd\'6', 'e\'6', 'f\'6', 'g\'6',
                            'a\'6', 'b\'6', 'c\'7', 'd\'7', 'e\'7', 'f\'7', 'g\'7',
                            'a\'7', 'b\'7', 'c\'8']
        notelist = ['A0', 'B0', 'C1', 'D1', 'E1', 'F1', 'G1',
                    'A1', 'B1', 'C2', 'D2', 'E2', 'F2', 'G2',
                    'A2', 'B2', 'C3', 'D3', 'E3', 'F3', 'G3',
                    'A3', 'B3', 'C4', 'D4', 'E4', 'F4', 'G4',
                    'A4', 'B4', 'C5', 'D5', 'E5', 'F5', 'G5',
                    'A5', 'B5', 'C6', 'D6', 'E6', 'F6', 'G6',
                    'A6', 'B6', 'C7', 'D7', 'E7', 'F7', 'G7',
                    'A7', 'B7', 'C8']
        self.note_to_int = {}
        for i in range(0, len(self.int_to_note)):
            self.note_to_int[self.int_to_note[i]] = i
        self.note_to_note = {}
        for i in range(0, len(notelist)):
            self.note_to_note[notelist[i]] = self.int_to_note[i]
        self.note_to_note["A"] = "a\'4"
        self.note_to_note["B"] = "b\'4"
        self.note_to_note["C"] = "c\'4"
        self.note_to_note["D"] = "d\'4"
        self.note_to_note["E"] = "e\'4"
        self.note_to_note["F"] = "f\'4"
        self.note_to_note["G"] = "g\'4"
        self.sheet = "\\version \"2.22.1\"\n\\score {\n\t\\absolute {\n\t\t\\tempo 4 = 120\n\t\t"
        self.filename = filename
        self.play = False

    def visitProgram(self, ctx):    # Checked
        l = list(ctx.getChildren())
        l.pop()  # getting rid of the <EOF> string
        # first, we visit all possible existing functions
        for i in range(0, len(l)):
            self.visit(l[i])
        # preparing the variable dictionary of main function
        self.context.append({})
        code = self.funs[self.main][1]
        for ins in code:
            self.visit(ins)
        self.sheet += "\n\t}\n \t\\layout { }\n\t\\midi { }\n}"
        if self.play:
            f = open(self.filename + ".lily", "w")
            f.write(self.sheet)
            f.close()
            os.system("lilypond " + self.filename + ".lily")
            os.system("timidity -Ow -o " + self.filename +
                      ".wav " + self.filename + ".midi")
            os.system("ffmpeg -i " + self.filename +
                      ".wav -codec:a libmp3lame -qscale:a 2 " + self.filename + ".mp3")

    def visitFunction(self, ctx):   # checked
        l = list(ctx.getChildren())
        Id = l[0].getText()
        if Id in self.funs:
            raise Exception(
                "Error: s'ha introduït el nom d'una funcio ja existent")
        params = []
        i = 2
        if ctx.parameters() is not None:
            params = self.visit(l[1])
            i = 3
        self.funs[l[0].getText()] = (params, l[i:(len(l)-1)])

    def visitParameters(self, ctx):  # checked
        l = list(ctx.getChildren())
        res = []
        for var in l:
            if var.getText() in res:
                raise Exception(
                    "Error: hi ha (almenys) dos parametres formalment definits de la mateixa manera")
            res.append(var.getText())
        return res

    def visitAssign(self, ctx):     # checked
        varlist = self.context[self.nivell]  # get variable dict
        l = list(ctx.getChildren())
        val = self.visit(l[2])  # get assignment value
        if isinstance(val, list):   # check if variable was a list or else
            varlist[l[0].getText()] = list(val)
        else:
            varlist[l[0].getText()] = val

    def visitIf(self, ctx):     # checked
        l = list(ctx.getChildren())
        val = self.visit(l[1])
        if(val):
            ret = self.visit(l[3])
            if ret is not None:
                return ret

    def visitIfElse(self, ctx):     # checked
        l = list(ctx.getChildren())
        val = self.visit(l[1])
        ret = None
        if(val):
            ret = self.visit(l[3])
        else:
            ret = self.visit(l[7])
        if ret is not None:
            return ret

    def visitWhile(self, ctx):      # checked
        l = list(ctx.getChildren())
        l.pop()
        val = self.visit(l[1])
        while(val):
            for i in range(3, len(l)):
                self.visit(l[i])
            val = self.visit(l[1])

    def visitCall(self, ctx):           # checked
        l = list(ctx.getChildren())
        Id = l[0].getText()
        if Id not in self.funs:
            raise Exception(
                "Error: s'ha introduït el nom d'una funcio inexistent")
        params = self.funs[Id][0]
        self.context.append({})
        if ctx.list_expr() is not None:
            vals = self.visit(l[1])
            if len(params) != len(vals):
                raise Exception(
                    "Error: el nombre de parametres de la funcio no coincideix amb el nombre de valors enviats")
            for i in range(0, len(vals)):
                param = params[i]
                self.context[self.nivell+1][param] = vals[i]
        self.nivell += 1
        code = self.funs[Id][1]
        for ins in code:
            self.visit(ins)
        self.context.pop()
        self.nivell -= 1

    def visitRead(self, ctx):       # checked
        l = list(ctx.getChildren())
        val = input()
        varlist = self.context[self.nivell]
        var = l[1].getText()
        varlist[var] = int(val)

    def visitWrite(self, ctx):      # checked
        l = list(ctx.getChildren())
        val = self.visit(l[1])
        for x in val:
            if(isinstance(x, list)):
                print("[ ", end='')
                print(*x, sep=",", end='')
                print(" ]", end=' ')
            else:
                print(x, end=' ')
        print()

    def visitPlay(self, ctx):       # checked
        l = list(ctx.getChildren())
        notes = self.visit(l[1])
        for note in notes:
            if(isinstance(note, int)):
                if(note >= len(self.int_to_note) or note < 0):
                    raise Exception(
                        "Error: s'ha intentat enregistrar un enter que no correspon a cap nota")
                else:
                    self.sheet += self.int_to_note[note] + " "
            elif(isinstance(note, str)):
                self.sheet += self.note_to_note[note] + " "
            else:
                for elem in note:
                    if(isinstance(elem, str)):
                        self.sheet += self.note_to_note[elem] + " "
                    else:
                        self.sheet += self.int_to_note[elem] + " "
        self.play = True

    def visitTrim(self, ctx):       # checked
        l = list(ctx.getChildren())
        var = l[1].getText()
        val = self.visit(l[3])
        varlist = self.context[self.nivell]
        if(val < 1 or val > len(varlist[var])):
            raise Exception(
                "Error: s'ha intentat accedir una posicio fora de la llista")
        varlist[var].pop(val-1)

    def visitAdd(self, ctx):        # checked
        l = list(ctx.getChildren())
        var = l[0].getText()
        varlist = self.context[self.nivell]
        val = self.visit(l[2])
        varlist[var].append(val)

    def visitStatements(self, ctx):   # checked
        l = list(ctx.getChildren())
        for statement in l:
            ret = self.visit(statement)
            if ret is not None:
                return ret

    def visitList_note(self, ctx):  # checked
        l = list(ctx.getChildren())
        notes = []
        for child in l:     # we create a list of the present notes
            notes.append(child.getText())
        return notes

    def visitNoteList(self, ctx):   # checked
        l = list(ctx.getChildren())
        if ctx.list_note() is not None:    # check if list of notes is empty
            return self.visit(l[1])
        return []

    def visitListAccess(self, ctx):  # checked
        l = list(ctx.getChildren())
        varlist = self.context[self.nivell]
        var = l[0].getText()
        if(var not in varlist):
            varlist[var] = 0
        vals = varlist[var]
        if(not isinstance(vals, list)):
            raise Exception("Error: la variable referenciada no es una llista")
        val = int(self.visit(l[2]))
        return vals[val-1]

    def visitLength(self, ctx):         # checked
        l = list(ctx.getChildren())
        var = l[1].getText()
        varlist = self.context[self.nivell]
        return len(varlist[var])

    def visitArithmetic(self, ctx):     # checked
        l = list(ctx.getChildren())
        a = self.visit(l[0])
        b = self.visit(l[2])
        if(isinstance(a, str)):
            a = self.note_to_int[self.note_to_note[a]]
        if(isinstance(b, str)):
            b = self.note_to_int[self.note_to_note[b]]
        if(ctx.SUM()):
            return a + b
        elif(ctx.SUB()):
            return a - b
        elif(ctx.MUL()):
            return a * b
        elif(ctx.DIV()):
            div = b
            if div == 0:
                raise Exception("Error: intent de fer una divisio per 0")
            return a // div
        elif(ctx.MOD()):
            return a % b

    def visitRelational(self, ctx):     # checked
        l = list(ctx.getChildren())
        a = self.visit(l[0])
        b = self.visit(l[2])
        if(isinstance(a, str)):
            a = self.note_to_int[self.note_to_note[a]]
        if(isinstance(b, str)):
            b = self.note_to_int[self.note_to_note[b]]
        if(ctx.EQUAL()):
            return a == b
        elif(ctx.NEQUAL()):
            return a != b
        elif(ctx.GT()):
            return a > b
        elif(ctx.GEQ()):
            return a >= b
        elif(ctx.LT()):
            return a < b
        elif(ctx.LEQ()):
            return a <= b

    def visitParenths(self, ctx):       # checked
        l = list(ctx.getChildren())
        return self.visit(l[1])

    def visitValue(self, ctx):          # checked
        l = list(ctx.getChildren())
        return int(l[0].getText())

    def visitVar(self, ctx):            # checked
        l = list(ctx.getChildren())
        var = l[0].getText()
        varlist = self.context[self.nivell]
        return varlist[var]

    def visitNote(self, ctx):           # checked
        l = list(ctx.getChildren())
        return l[0].getText()

    def visitString(self, ctx):         # checked
        l = list(ctx.getChildren())
        string = l[0].getText()
        n = len(string)
        return string[1:n-1]

    def visitList_expr(self, ctx):      # checked
        l = list(ctx.getChildren())
        vals = []
        for i in range(0, len(l)):
            val = self.visit(l[i])
            vals.append(val)
        return vals


input_stream = FileStream(sys.argv[1], encoding='utf-8')
lexer = jsbachLexer(input_stream)
token_stream = CommonTokenStream(lexer)
parser = jsbachParser(token_stream)
tree = parser.program()
# print(tree.toStringTree(recog=parser))

# visitor = TreeVisitor()
# visitor.visit(tree)

main = "Main"
filename = os.path.splitext(sys.argv[1])[0]
if(len(sys.argv) > 2):
    main = sys.argv[2]
visitor = EvalVisitor(main, filename)
visitor.visit(tree)
