--- `algo.Iterator` class.
-- An iterator for any container that provides `next` and `reset` method.
-- `next` method return an element on each run; `reset` method reset the
-- internal iterator.  See `algo.Array` and `algo.List` for the examples of
-- `next` and `reset` methods.
-- @classmod Iterator
local Heap = require "algo.Heap"
local Iterator = {}
package.loaded['Iterator'] = Iterator

Iterator.__index = Iterator

--- Create a new iterator object
-- @param obj the iterator; any container implementing `next` and
-- `reset` methods will suffice
-- @return an iterator object.
function Iterator:new(obj)
  -- Check whether both next and reset methods exist
  assert(obj["next"])
  assert(obj["reset"])

  self = {}
  setmetatable(self, Iterator)
  self.obj = obj
  return self
end

--- Take the iterator into a new iterator by mapper.
-- @param func the mapper. function (x) -> x_1
-- @return an iterator
function Iterator:map(func)
  assert(func ~= nil)
  local m = nil
  self.obj:reset()
  local n = self.obj:next()()

  return function()
    if n ~= nil then
      m = n
      n = self.obj:next()()
      return func(m)
    else
      return nil
    end
  end
end

--- Filter out elements not fitting the predicate
-- @param func the predicate, function (x) -> bool
-- @return an iterator
function Iterator:filter(func)
  assert(func ~= nil)

  local m = nil
  self.obj:reset()
  local n = self.obj:next()()

  return function()
    ::redo::
    if n ~= nil then
      m = n
      n = self.obj:next()()
      if func(m) then
        return m
      else
        goto redo
      end
    else
      return nil
    end
  end
end

--- Check whether any element in the iterator fits the predicate.
-- @param func the predicate, function (x) -> bool
-- @return true when any element fits the predicate; otherwise, false.
function Iterator:any(func)
  assert(func ~= nil)

  local m = nil
  self.obj:reset()
  local n = self.obj:next()()

  ::redo::
  if n ~= nil then
    m = n
    n = self.obj:next()()
    if func(m) then
      return true
    else
      goto redo
    end
  else
    return false
  end
end

--- Check whether all elements in the iterator fit the predicate.
-- @param func the predicate, function (x) -> bool
-- @return true when all elements in the iterator fit the predicate;
-- otherwise, false.
function Iterator:all(func)
  assert(func ~= nil)

  local m = nil
  self.obj:reset()
  local n = self.obj:next()()

  if n == nil then
    return false
  end

  while n ~= nil do
    m = n
    n = self.obj:next()()

    if not func(m) then
      return false
    end
  end

  return true
end

--- Get the first element fitting the predicate in the iterator.
-- @param func the predicate, function (x) -> bool
-- @return The first element
function Iterator:first(func)
  assert(func ~= nil)

  local m = nil
  self.obj:reset()
  local n = self.obj:next()()

  while n ~= nil do
    m = n
    n = self.obj:next()()

    if func(m) then
      return m
    end
  end

  return nil
end

--- Get the maximum in the iterator.
-- @param func  Optional, a function presents the rank of the element
-- @return the maximal element
function Iterator:max(func)
  if func == nil then
    func = function (x) return x end
  end

  local m = nil
  self.obj:reset()
  local n = self.obj:next()()
  local max = n

  ::redo::
  if n ~= nil then
    m = n
    n = self.obj:next()()
    if n == nil then
      if func(m) > func(max) then
        return m
      else
        return max
      end
    else
      if func(m) > func(max) then
        max = m
      end
      goto redo
    end
  else
    return nil
  end
end

--- Get the minimum in the iterator.
-- @param func  Optional, a function presents the rank of the element
-- @return The minimal element
function Iterator:min(func)
  if func == nil then
    func = function (x) return x end
  end

  local m = nil
  self.obj:reset()
  local n = self.obj:next()()
  local min = n

  ::redo::
  if n ~= nil then
    m = n
    n = self.obj:next()()
    if n == nil then
      if func(m) < func(min) then
        return m
      else
        return min
      end
    else
      if func(m) < func(min) then
        min = m
      end
      goto redo
    end
  else
    return nil
  end
end

--- Reduce an iterator into a scalar
-- @param func the reducer, function (a, b) -> scalar
-- @return A scalar
function Iterator:reduce(func)
  assert(func ~= nil)
  local m = nil
  self.obj:reset()
  local n = self.obj:next()()
  local result = n

  ::redo::
  if n ~= nil then
    m = result
    n = self.obj:next()()
    if n == nil then
      return result
    else
      result = func(m, n)
      goto redo
    end
  else
    return nil
  end
end

--- Sort the iterator.
-- Sorting the iterator with heap sort internally.
-- @param func the comparison function, optional.  Default to
-- `function (a, b) return a < b end`
-- @return An sorted iterator.
function Iterator:sort(func)
  if func == nil then
    func = function (a, b) return a < b end
  end

  self.obj:reset()
  local m = nil
  local heap = Heap:new(func)

  for e in self.obj:next() do
    heap:push(e)
  end

  return function ()
    return heap:pop()
  end
end

--- Zip up two iterators into a single iterator of pairs.  When one of the two
-- iterators becomes `nil`, return (nil, nil) pair.
-- @param other the other iterator
-- @return An iterator of (element_1, element_2) pairs
function Iterator:zip(other)
  local m1 = nil
  self.obj:reset()
  local n1 = self.obj:next()()

  local m2 = nil
  other:reset()
  local n2 = other:next()()

  return function()
    if n1 ~= nil and n2 ~= nil then
      m1 = n1
      n1 = self.obj:next()()

      m2 = n2
      n2 = other:next()()
      return m1, m2
    else
      return nil, nil
    end
  end
end

--- Get the iterator of (index, element) pairs
-- @return An iterator of (index, element) pairs
function Iterator:ipairs()
  local m = nil
  self.obj:reset()
  local n = self.obj:next()()
  local i = 0

  return function ()
    if n ~= nil then
      m = n
      n = self.obj:next()()
      i = i + 1
      return i, m
    else
      return nil, nil
    end
  end
end

return Iterator
