{.warning[UnusedImport]: off.}

import unittest

import data_structures_advanced

# Casos de prueba de la especificación 07_Data_Structures_Advanced.md:
# TreeNode (5 aplicables), BinaryTree (7) y Graph (12).
#
# Cada caso es un `test` con su propia instancia recién inicializada y sus pasos
# en orden. Los indicadores son valores devueltos, nunca excepciones: `false`
# para el fallo de `insert`/`add_*`/`contains`/`has_edge`, y `nil` para el fallo
# de `getNeighbors` (distinto de la secuencia vacía, que es un `ref seq` no nulo).
#
# Adaptaciones declaradas:
# - "Adaptación inmutable" de TreeNode: no aplica, `TreeNode` es un `ref object`
#   mutable y `setLeft`/`setRight` actualizan el enlace en el sitio.
# - La ausencia de un enlace es `nil`.
# - `getNeighbors` devuelve `ref seq[int]`; "modificar otra copia devuelta" se
#   prueba mutando el resultado de una consulta distinta a la guardada.
const
  parentValue = 10
  leftValue = 20
  rightValue = 30

  treeRootValue = 50
  treeLowerValue = 30
  treeHigherValue = 70
  treeLeftLeafValue = 20
  treeRightLeafValue = 40
  treeAbsentValue = 99

  vertexA = 10
  vertexB = 30
  vertexC = 50
  vertexD = 70
  missingVertex = 99
  missingVertexOther = 98

  emptySize = 0

template step(subject, description: string, observed, expected: untyped) =
  checkpoint subject & " should " & description
  check (observed) == (expected)

proc neighborsOf(graph: Graph, u: int): seq[int] =
  let found = getNeighbors(graph, u)
  if found.isNil: @[] else: found[]

proc itemsOf(found: ref seq[int]): seq[int] =
  if found.isNil: @[] else: found[]

proc hasNeighbors(graph: Graph, u: int): bool =
  not getNeighbors(graph, u).isNil

suite "TreeNode":
  test "Create a tree node":
    let node = newTreeNode(parentValue)
    step "TreeNode", "assign the value on init", getValue(node), parentValue

  test "Absent initial links":
    let node = newTreeNode(parentValue)
    step "TreeNode", "leave the left link absent on init", getLeft(node).isNil, true
    step "TreeNode", "leave the right link absent on init", getRight(node).isNil, true

  test "Link two children":
    let parent = newTreeNode(parentValue)
    setLeft(parent, newTreeNode(leftValue))
    setRight(parent, newTreeNode(rightValue))
    step "TreeNode", "return the left child value", getValue(getLeft(parent)), leftValue
    step "TreeNode", "return the right child value", getValue(getRight(parent)), rightValue

  test "Traverse each link":
    let parent = newTreeNode(parentValue)
    setLeft(parent, newTreeNode(leftValue))
    setRight(parent, newTreeNode(rightValue))
    let left = getLeft(parent)
    let right = getRight(parent)
    step "TreeNode", "lead to the left child value", getValue(left), leftValue
    step "TreeNode", "lead to the right child value", getValue(right), rightValue
    step "TreeNode", "leave the left child's left link absent", getLeft(left).isNil, true
    step "TreeNode", "leave the left child's right link absent", getRight(left).isNil, true
    step "TreeNode", "leave the right child's left link absent", getLeft(right).isNil, true
    step "TreeNode", "leave the right child's right link absent", getRight(right).isNil, true

  test "Unlink children":
    let parent = newTreeNode(parentValue)
    setLeft(parent, newTreeNode(leftValue))
    setRight(parent, newTreeNode(rightValue))
    setLeft(parent, nil)
    step "TreeNode", "clear the left link", getLeft(parent).isNil, true
    step "TreeNode", "keep the value after clearing left", getValue(parent), parentValue
    step "TreeNode", "keep the right child after clearing left", getValue(getRight(parent)), rightValue
    setRight(parent, nil)
    step "TreeNode", "clear the right link", getRight(parent).isNil, true
    step "TreeNode", "keep the left link absent after clearing right", getLeft(parent).isNil, true
    step "TreeNode", "keep the value after clearing right", getValue(parent), parentValue

suite "BinaryTree":
  test "Create empty":
    let tree = initBinaryTree()
    step "BinaryTree", "be empty after init", isEmpty(tree), true
    step "BinaryTree", "report size 0 after init", size(tree), emptySize
    step "BinaryTree", "not contain 50 after init", contains(tree, treeRootValue), false

  test "Insert the root":
    var tree = initBinaryTree()
    step "BinaryTree", "succeed inserting the root", insert(tree, treeRootValue), true
    step "BinaryTree", "report size 1", size(tree), 1
    step "BinaryTree", "not be empty", isEmpty(tree), false
    step "BinaryTree", "contain the root", contains(tree, treeRootValue), true

  test "Insert lower and higher":
    var tree = initBinaryTree()
    step "BinaryTree", "succeed inserting 50", insert(tree, treeRootValue), true
    step "BinaryTree", "succeed inserting 30", insert(tree, treeLowerValue), true
    step "BinaryTree", "succeed inserting 70", insert(tree, treeHigherValue), true
    step "BinaryTree", "report size 3", size(tree), 3
    step "BinaryTree", "contain 50", contains(tree, treeRootValue), true
    step "BinaryTree", "contain 30", contains(tree, treeLowerValue), true
    step "BinaryTree", "contain 70", contains(tree, treeHigherValue), true

  test "Multilevel branches":
    var tree = initBinaryTree()
    for value in [treeRootValue, treeLowerValue, treeHigherValue, treeLeftLeafValue, treeRightLeafValue]:
      step "BinaryTree", "succeed inserting " & $value, insert(tree, value), true
    for value in [treeRootValue, treeLowerValue, treeHigherValue, treeLeftLeafValue, treeRightLeafValue]:
      step "BinaryTree", "contain " & $value, contains(tree, value), true
    step "BinaryTree", "report size 5", size(tree), 5

  test "Missing value in nonempty tree":
    var tree = initBinaryTree()
    step "BinaryTree", "succeed inserting 50", insert(tree, treeRootValue), true
    step "BinaryTree", "not contain 99", contains(tree, treeAbsentValue), false
    step "BinaryTree", "keep size 1", size(tree), 1
    step "BinaryTree", "still contain 50", contains(tree, treeRootValue), true

  test "Idempotent duplicate":
    var tree = initBinaryTree()
    step "BinaryTree", "succeed inserting 50", insert(tree, treeRootValue), true
    step "BinaryTree", "succeed inserting 30", insert(tree, treeLowerValue), true
    step "BinaryTree", "succeed inserting 70", insert(tree, treeHigherValue), true
    step "BinaryTree", "succeed inserting duplicate 30", insert(tree, treeLowerValue), true
    step "BinaryTree", "report size 3 after the duplicate", size(tree), 3
    step "BinaryTree", "preserve 50", contains(tree, treeRootValue), true
    step "BinaryTree", "preserve 30", contains(tree, treeLowerValue), true
    step "BinaryTree", "preserve 70", contains(tree, treeHigherValue), true

  test "Ordered insertions":
    var tree = initBinaryTree()
    const ordered = [20, 30, 40, 50, 70]
    for value in ordered:
      step "BinaryTree", "succeed inserting " & $value, insert(tree, value), true
    step "BinaryTree", "report size 5", size(tree), 5
    for value in ordered:
      step "BinaryTree", "contain " & $value, contains(tree, value), true
    step "BinaryTree", "not contain 99", contains(tree, treeAbsentValue), false

suite "Graph":
  test "Create empty":
    let graph = initGraph()
    step "Graph", "be empty after init", isEmpty(graph), true
    step "Graph", "report 0 vertices", vertexCount(graph), emptySize
    step "Graph", "report 0 edges", edgeCount(graph), emptySize
    step "Graph", "fail has_edge(10,30)", hasEdge(graph, vertexA, vertexB), false
    step "Graph", "fail get_neighbors(10)", hasNeighbors(graph, vertexA), false

  test "Isolated vertex":
    var graph = initGraph()
    step "Graph", "succeed adding 10", addVertex(graph, vertexA), true
    step "Graph", "not be empty", isEmpty(graph), false
    step "Graph", "report 1 vertex", vertexCount(graph), 1
    step "Graph", "report 0 edges", edgeCount(graph), 0
    step "Graph", "return a result for the neighbours of 10", hasNeighbors(graph, vertexA), true
    step "Graph", "return empty neighbours of 10", neighborsOf(graph, vertexA), newSeq[int]()

  test "Nonconsecutive labels and directed edge":
    var graph = initGraph()
    step "Graph", "succeed adding 10", addVertex(graph, vertexA), true
    step "Graph", "succeed adding 70", addVertex(graph, vertexD), true
    step "Graph", "succeed adding edge (10,70)", addEdge(graph, vertexA, vertexD), true
    step "Graph", "have the forward edge", hasEdge(graph, vertexA, vertexD), true
    step "Graph", "not have the reverse edge", hasEdge(graph, vertexD, vertexA), false
    step "Graph", "report 2 vertices", vertexCount(graph), 2
    step "Graph", "report 1 edge", edgeCount(graph), 1

  test "Duplicate vertex preserves adjacency":
    var graph = initGraph()
    step "Graph", "succeed adding 10", addVertex(graph, vertexA), true
    step "Graph", "succeed adding 30", addVertex(graph, vertexB), true
    step "Graph", "succeed adding edge (10,30)", addEdge(graph, vertexA, vertexB), true
    step "Graph", "succeed adding duplicate vertex 10", addVertex(graph, vertexA), true
    step "Graph", "report 2 vertices", vertexCount(graph), 2
    step "Graph", "report 1 edge", edgeCount(graph), 1
    step "Graph", "keep neighbours of 10 as [30]", neighborsOf(graph, vertexA), @[vertexB]

  test "Duplicate edge":
    var graph = initGraph()
    step "Graph", "succeed adding 10", addVertex(graph, vertexA), true
    step "Graph", "succeed adding 30", addVertex(graph, vertexB), true
    step "Graph", "succeed adding edge (10,30)", addEdge(graph, vertexA, vertexB), true
    step "Graph", "succeed adding edge (10,30) again", addEdge(graph, vertexA, vertexB), true
    step "Graph", "report 2 vertices", vertexCount(graph), 2
    step "Graph", "report 1 edge", edgeCount(graph), 1
    step "Graph", "keep neighbours of 10 as [30]", neighborsOf(graph, vertexA), @[vertexB]

  test "Missing endpoint without mutation":
    var graph = initGraph()
    step "Graph", "succeed adding 10", addVertex(graph, vertexA), true
    step "Graph", "succeed adding 30", addVertex(graph, vertexB), true
    step "Graph", "succeed adding edge (10,30)", addEdge(graph, vertexA, vertexB), true
    step "Graph", "fail edge (10,99)", addEdge(graph, vertexA, missingVertex), false
    step "Graph", "fail edge (99,10)", addEdge(graph, missingVertex, vertexA), false
    step "Graph", "fail edge (98,99)", addEdge(graph, missingVertexOther, missingVertex), false
    step "Graph", "fail edge (99,99)", addEdge(graph, missingVertex, missingVertex), false
    step "Graph", "keep 2 vertices", vertexCount(graph), 2
    step "Graph", "keep 1 edge", edgeCount(graph), 1
    step "Graph", "keep neighbours of 10 as [30]", neighborsOf(graph, vertexA), @[vertexB]
    step "Graph", "keep neighbours of 30 empty", hasNeighbors(graph, vertexB) and neighborsOf(graph, vertexB).len == 0, true
    step "Graph", "not have edge (10,99)", hasEdge(graph, vertexA, missingVertex), false
    step "Graph", "not have edge (99,10)", hasEdge(graph, missingVertex, vertexA), false
    step "Graph", "not have edge (98,99)", hasEdge(graph, missingVertexOther, missingVertex), false
    step "Graph", "not have edge (99,99)", hasEdge(graph, missingVertex, missingVertex), false
    step "Graph", "fail get_neighbors(98)", hasNeighbors(graph, missingVertexOther), false
    step "Graph", "fail get_neighbors(99)", hasNeighbors(graph, missingVertex), false

  test "Sorted neighbours and counts":
    var graph = initGraph()
    for label in [vertexA, vertexB, vertexC, vertexD]:
      step "Graph", "succeed adding " & $label, addVertex(graph, label), true
    step "Graph", "succeed adding edge (10,70)", addEdge(graph, vertexA, vertexD), true
    step "Graph", "succeed adding edge (10,30)", addEdge(graph, vertexA, vertexB), true
    step "Graph", "succeed adding edge (10,50)", addEdge(graph, vertexA, vertexC), true
    step "Graph", "succeed adding edge (30,50)", addEdge(graph, vertexB, vertexC), true
    step "Graph", "sort neighbours of 10", neighborsOf(graph, vertexA), @[vertexB, vertexC, vertexD]
    step "Graph", "list neighbours of 30", neighborsOf(graph, vertexB), @[vertexC]
    step "Graph", "leave 50 without neighbours", hasNeighbors(graph, vertexC) and neighborsOf(graph, vertexC).len == 0, true
    step "Graph", "leave 70 without neighbours", hasNeighbors(graph, vertexD) and neighborsOf(graph, vertexD).len == 0, true
    step "Graph", "report 4 vertices", vertexCount(graph), 4
    step "Graph", "report 4 edges", edgeCount(graph), 4

  test "Missing-edge query":
    var graph = initGraph()
    step "Graph", "succeed adding 10", addVertex(graph, vertexA), true
    step "Graph", "succeed adding 30", addVertex(graph, vertexB), true
    step "Graph", "fail has_edge(10,30)", hasEdge(graph, vertexA, vertexB), false
    step "Graph", "report 2 vertices", vertexCount(graph), 2
    step "Graph", "report 0 edges", edgeCount(graph), 0
    step "Graph", "not be empty", isEmpty(graph), false

  test "Neighbours of missing vertex":
    var graph = initGraph()
    step "Graph", "succeed adding 10", addVertex(graph, vertexA), true
    step "Graph", "fail get_neighbors(99)", hasNeighbors(graph, missingVertex), false
    step "Graph", "distinguish failure from the empty neighbours of 10", hasNeighbors(graph, vertexA), true
    step "Graph", "report 1 vertex", vertexCount(graph), 1
    step "Graph", "report 0 edges", edgeCount(graph), 0

  test "Self-loop and duplicate":
    var graph = initGraph()
    step "Graph", "succeed adding 10", addVertex(graph, vertexA), true
    step "Graph", "succeed adding loop (10,10)", addEdge(graph, vertexA, vertexA), true
    step "Graph", "succeed adding loop (10,10) again", addEdge(graph, vertexA, vertexA), true
    step "Graph", "have the loop", hasEdge(graph, vertexA, vertexA), true
    step "Graph", "list the loop as the only neighbour", neighborsOf(graph, vertexA), @[vertexA]
    step "Graph", "report 1 vertex", vertexCount(graph), 1
    step "Graph", "report 1 edge", edgeCount(graph), 1

  test "Neighbour-result isolation":
    var graph = initGraph()
    for label in [vertexA, vertexB, vertexC]:
      step "Graph", "succeed adding " & $label, addVertex(graph, label), true
    step "Graph", "succeed adding edge (10,30)", addEdge(graph, vertexA, vertexB), true
    let saved = getNeighbors(graph, vertexA)
    let copy = getNeighbors(graph, vertexA)
    step "Graph", "return a result for 10", saved.isNil or copy.isNil, false
    if not copy.isNil:
      copy[].add(missingVertex)
    step "Graph", "not change the graph when another copy is modified", neighborsOf(graph, vertexA), @[vertexB]
    step "Graph", "keep the saved result as [30]", itemsOf(saved), @[vertexB]
    step "Graph", "succeed adding edge (10,50)", addEdge(graph, vertexA, vertexC), true
    step "Graph", "keep the saved result as [30] after the insertion", itemsOf(saved), @[vertexB]
    step "Graph", "return [30,50] on a fresh query", neighborsOf(graph, vertexA), @[vertexB, vertexC]
    step "Graph", "report 3 vertices", vertexCount(graph), 3
    step "Graph", "report 2 edges", edgeCount(graph), 2
