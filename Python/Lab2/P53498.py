class Tree:
    def __init__(self, x):
        self.rt = x
        self.child = []
        
    def addChild(self, a):
        self.child.append(a)
        
    def root(self):
        return self.rt
    
    def ithChild(self, x):
        return self.child[x]
        
    def numChildren(self):
        return len(self.child)
    
    def getChild(self):
        return self.child
    
    def __iter__(self):
        yield self.rt
        ls = self.child
        while len(ls) != 0:
            x = ls.pop(0)
            if len(x.child) != 0:
                ls = ls + x.child
            yield x.rt
