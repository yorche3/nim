type
  Node = ref object of RootObj
    value: int

  TreeNode* = ref object of Node
    left: TreeNode
    right: TreeNode

  BinaryTree* = object
    root: TreeNode
    count: int

  NeighborNode = ref object
    label: int
    next: NeighborNode

  GraphNode = ref object of Node
    neighbors: NeighborNode
    nextVertex: GraphNode

  Graph* = object
    vertices: GraphNode
    vertexTotal: int
    edges: int

proc initNode(node: Node, value: int) {.used.} =
  discard

func getValue*(node: Node): int =
  0

func newTreeNode*(value: int): TreeNode =
  nil

func getLeft*(node: TreeNode): TreeNode =
  nil

func getRight*(node: TreeNode): TreeNode =
  nil

proc setLeft*(node, child: TreeNode) =
  discard

proc setRight*(node, child: TreeNode) =
  discard

func initBinaryTree*(): BinaryTree =
  default(BinaryTree)

proc insert*(tree: var BinaryTree, value: int): bool =
  false

func contains*(tree: BinaryTree, value: int): bool =
  false

func isEmpty*(tree: BinaryTree): bool =
  false

func size*(tree: BinaryTree): int =
  0

func newGraphNode(label: int): GraphNode {.used.} =
  nil

func initGraph*(): Graph =
  default(Graph)

proc addVertex*(graph: var Graph, label: int): bool =
  false

proc addEdge*(graph: var Graph, u, v: int): bool =
  false

func hasEdge*(graph: Graph, u, v: int): bool =
  false

func getNeighbors*(graph: Graph, u: int): ref seq[int] =
  nil

func isEmpty*(graph: Graph): bool =
  false

func vertexCount*(graph: Graph): int =
  0

func edgeCount*(graph: Graph): int =
  0
