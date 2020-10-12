class Node:
    def __init__(self, key):
       self.left = None
       self.right = None
       self.key = key

def find_path(root, path, k):
    if root is None:
        return False
    
    path.append(root.key)
    if(root.key == k):
        return True
    if((root.left != None and find_path(root.left, path, k)) or (root.right != None and find_path(root.right, path, k))):
       return True
    path.pop()
    return False
def LCA(root, x, y):
    p1 = []
    p2 = []
    if(not find_path(root, p1, x) or not find_path(root, p2, y)):
        return -1
    k = 0
    while(k < len(p1) and k < len(p2)):
        if(p1[k] != p2[k]):
            break
        k = k + 1
    return p1[k-1]

