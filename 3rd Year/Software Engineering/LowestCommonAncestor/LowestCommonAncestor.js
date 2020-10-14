class Node {
  constructor(key) {
    this.left = null;
    this.right = null;
    this.key = key;
  }
}

const LCA = (root, p, q) => {
  const LCA_inner = (root, p, q) => {
    if (root == null) return root;
    if (root.key == p || root.key == q) return root;
    var left = LCA_inner(root.left, p, q);
    var right = LCA_inner(root.right, p, q);
    if (left != null && right != null) return root;
    if (left == null && right == null) return null;
    return left != null ? left : right;
  };
  return LCA_inner(root, p, q).key;
};

let root = new Node(1);
root.left = new Node(2);
root.right = new Node(3);
root.left.left = new Node(4);
root.left.right = new Node(5);
root.right.left = new Node(6);
root.right.right = new Node(7);
a1 = LCA(root, 4, 5);
a2 = LCA(root, 4, 6);
a3 = LCA(root, 3, 4);
a4 = LCA(root, 2, 4);
console.log(a1, a2, a3, a4);
