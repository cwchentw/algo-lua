--- `algo.NaiveBSTree` class.
-- A naive binary search tree.  The module intends to demonstrate how a binary
-- search tree is implemented.  You should not rely on the class in your tasks;
-- instead, you should use a self-balancing binary search tree in `algo.BSTree`.
-- @classmod NaiveBSTree
local NaiveBSTree = {}
package.loaded['NaiveBSTree'] = NaiveBSTree

NaiveBSTree.__index = NaiveBSTree

local Node = {}
Node.__index = Node

function Node:new(e)
  self = {}
  setmetatable(self, Node)

  self.element = e
  self.left = nil
  self.right = nil

  return self
end

function Node:clear()
  self = nil
end

--- Create an empty binary search tree.
-- @param func Optional.  A function present the rank of elements.  Default to
-- `function (x) return x end`.
-- @return A binary search tree.
function NaiveBSTree:new(func)
  if func == nil then
    func = function (x) return x end
  end

  self = {}
  setmetatable(self, NaiveBSTree)

  self.tree = nil
  self.func = func

  return self
end

--- Create a binary tree with the elements in an array-style table.
-- @param table an array-style table.
-- @param func Optional.  See `new` for the detail.
-- @return A binary search tree.
function NaiveBSTree:from_table(table, func)
  local tree = NaiveBSTree:new(func)

  for _, v in pairs(table) do
    tree:insert(v)
  end

  return tree
end

-- Insert an element to an node.
local function _tree_insert(node, e, func)
  assert(node ~= nil)

  local new_node = Node:new(e)
  if func(node.element) < func(e) then
    if node.right == nil then
      node.right = new_node
    else
      _tree_insert(node.right, e, func)
    end
  else
    if node.left == nil then
      node.left = new_node
    else
      _tree_insert(node.left, e, func)
    end
  end
end

--- Insert an element into the tree.
-- @param e an element
function NaiveBSTree:insert(e)
  local node = Node:new(e)

  if self.tree == nil then
    self.tree = node
  else
    _tree_insert(self.tree, e, self.func)
  end
end

-- Check whether an element is in the tree.
local function _tree_find(node, e, func)
  if node == nil then
    return false
  elseif func(node.element) < func(e) then
    return _tree_find(node.right, e, func)
  elseif func(node.element) > func(e) then
    return _tree_find(node.left, e, func)
  else
    return true
  end
end

--- Check whether the tree contains the element.
-- @param e the element to find
-- @return true or false
function NaiveBSTree:contain(e)
  return _tree_find(self.tree, e, self.func)
end

local function _tree_min(node)
  if node == nil then
    return nil
  elseif node.left == nil then
    return node.element
  else
    return _tree_min(node.left)
  end
end

function NaiveBSTree:min()
  return _tree_min(self.tree)
end

local function _tree_max(node)
  if node == nil then
    return nil
  elseif node.right == nil then
    return node.element
  else
    return _tree_max(node.right)
  end
end

function NaiveBSTree:max()
  return _tree_max(self.tree)
end

local function _tree_remove(node, e, func)
  if node == nil then
    return node
  elseif func(node.element) < func(e) then
    node.right = _tree_remove(node.right, e, func)
  elseif func(node.element) > func(e) then
    node.left = _tree_remove(node.left, e, func)
  else
    if node.left == nil then
      return node.right
    elseif node.right == nil then
      return node.left
    else
      local min = _tree_min(node.right)
      node.element = min
      node.right = _tree_remove(node.right, min, func)
    end
  end

  return node
end

--- Remove the element from the tree.
-- @param e the element to remove
function NaiveBSTree:remove(e)
  self.tree = _tree_remove(self.tree, e, self.func)
end

function _tree_pop_max(node)
  local max = nil
  if node == nil then
    return node, max
  elseif node.right == nil then
    return node.left, node.element
  else
    node.right, m = _tree_pop_max(node.right)
    max = m
  end

  return node, max
end

function NaiveBSTree:pop_max()
  local max = nil
  self.tree, m = _tree_pop_max(self.tree)
  max = m
  return max
end

return NaiveBSTree
