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
  node.value = value
func getValue*(node: Node): int =
  node.value

func newTreeNode*(value: int): TreeNode =
  TreeNode(value: value, left: nil, right: nil)

func getLeft*(node: TreeNode): TreeNode =
  node.left

func getRight*(node: TreeNode): TreeNode =
  node.right

proc setLeft*(node, child: TreeNode) =
  node.left = child

proc setRight*(node, child: TreeNode) =
  node.right = child

func initBinaryTree*(): BinaryTree =
  BinaryTree(root: nil, count: 0)

proc insert*(tree: var BinaryTree, value: int): bool =
  if tree.root == nil:
    tree.root = newTreeNode(value)
    tree.count.inc()
    return true
  var current = tree.root
  while true:
    if value == current.value:
      return true
    elif value < current.value:
      if current.left == nil:
        current.left = newTreeNode(value)
        tree.count.inc()
        return true
      current = current.left
    else:
      if current.right == nil:
        current.right = newTreeNode(value)
        tree.count.inc()
        return true
      current = current.right

func contains*(tree: BinaryTree, value: int): bool =
  var current = tree.root
  while current != nil:
    if value == current.value:
      return true
    elif value < current.value:
      current = current.left
    else:
      current = current.right
  return false

func isEmpty*(tree: BinaryTree): bool =
  tree.count == 0

func size*(tree: BinaryTree): int =
  tree.count

func newGraphNode(label: int): GraphNode {.used.} =
  GraphNode(value: label, neighbors: nil, nextVertex: nil)

func initGraph*(): Graph =
  Graph(vertices: nil, vertexTotal: 0, edges: 0)

func findVertex(graph: Graph, label: int): GraphNode =
  var current = graph.vertices
  while current != nil:
    if current.value == label:
      return current
    current = current.nextVertex
  return nil

func hasNeighbor(vertex: GraphNode, label: int): bool =
  var current = vertex.neighbors
  while current != nil:
    if current.label == label:
      return true
    current = current.next
  return false

proc insertNeighbor(vertex: GraphNode, label: int) =
  var previous: NeighborNode = nil
  var current = vertex.neighbors
  while current != nil and current.label < label:
    previous = current
    current = current.next
  let fresh = NeighborNode(label: label, next: current)
  if previous == nil:
    vertex.neighbors = fresh
  else:
    previous.next = fresh

proc addVertex*(graph: var Graph, label: int): bool =
  if findVertex(graph, label) != nil:
    return true
  let newVertex = newGraphNode(label)
  newVertex.nextVertex = graph.vertices
  graph.vertices = newVertex
  graph.vertexTotal.inc()
  return true

proc addEdge*(graph: var Graph, u, v: int): bool =
  let uVertex = findVertex(graph, u)
  if uVertex == nil or findVertex(graph, v) == nil:
    return false
  if hasNeighbor(uVertex, v):
    return true
  insertNeighbor(uVertex, v)
  graph.edges.inc()
  return true

func hasEdge*(graph: Graph, u, v: int): bool =
  let uVertex = findVertex(graph, u)
  if uVertex == nil:
    return false
  return hasNeighbor(uVertex, v)

func getNeighbors*(graph: Graph, u: int): ref seq[int] =
  let uVertex = findVertex(graph, u)
  if uVertex == nil:
    return nil
  var neighbors = new(seq[int])
  var current = uVertex.neighbors
  while current != nil:
    neighbors[].add(current.label)
    current = current.next
  return neighbors

func isEmpty*(graph: Graph): bool =
  graph.vertexTotal == 0

func vertexCount*(graph: Graph): int =
  graph.vertexTotal

func edgeCount*(graph: Graph): int =
  graph.edges
