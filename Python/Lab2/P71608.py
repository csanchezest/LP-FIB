class Tree:
    def __init__(self, x):
        self.rt = x
        self.child = []
        
    def add_child(self, a):
        self.child.append(a)
        
    def root(self):
        return self.rt
    
    def ith_child(self, x):
        return self.child[x]
        
    def num_children(self):
        return len(self.child)
    
    
class Pre(Tree):
    def __init__(self, x):
        super().__init__(x)
    
    def preorder(self) :
        if self.child == []:
            return [self.rt]
        ls = []
        ls.append(self.rt)
        for v in self.child:
            ls = ls + v.preorder()
        return ls
