//// A MultiSet (aka MultiSet)
//// A data structure that's like a set, but allows duplicate elements
//// and keeps track of how many times each element appears.

import gleam/dict.{type Dict}
import gleam/int
import gleam/option.{None, Some}
import gleam/result
import gleam/set

pub opaque type MultiSet(v) {
  MultiSet(bag: Dict(v, Int))
}

pub fn new() {
  MultiSet(bag: dict.new())
}

/// Insert an element
pub fn insert(into into: MultiSet(v), value value: v) {
  modify(into, value, 1)
}

/// Insert or remove an element by the given count
/// It is possible to pass a negative number here
/// But the count for an element cannot go below zero.
pub fn modify(into into: MultiSet(v), value value: v, count count: Int) {
  let bag =
    dict.upsert(into.bag, value, fn(option) {
      case option {
        Some(current) -> int.max(current + count, 0)
        None -> int.max(count, 0)
      }
    })

  MultiSet(bag:)
}

pub fn get(from from: MultiSet(v), value value: v) {
  dict.get(from.bag, value) |> result.unwrap(0)
}

// Delete an element if present.
pub fn delete(from from: MultiSet(v), value value: v) {
  modify(from, value, -1)
}

// Substract the second from the first
// ```
// a = {red: 2, blue: 3}
// b = {red: 1, blue: 1, green: 1}
// a - b = {red: 1, blue: 2}
// ```
pub fn difference(of first: MultiSet(v), and second: MultiSet(v)) {
  let in_first = dict.keys(first.bag)

  let second_with_relevant_keys =
    second.bag
    |> dict.take(in_first)

  let bag =
    dict.combine(first.bag, second_with_relevant_keys, fn(a, b) {
      int.max(a - b, 0)
    })
  MultiSet(bag:)
}

// Intersection (∩) returns the min count for each element that is present in both
// ```
// a = {red: 2, blue: 2}
// b = {red: 1, blue: 3, green: 1}
// a ∩ b = { red: 1, blue: 2 }
// ```
pub fn intersection(of first: MultiSet(v), and second: MultiSet(v)) {
  let in_first = dict.keys(first.bag) |> set.from_list
  let in_second = dict.keys(second.bag) |> set.from_list
  let in_boths = set.intersection(in_first, in_second) |> set.to_list
  let relevant_first = dict.take(first.bag, in_boths)
  let relevant_second = dict.take(second.bag, in_boths)
  let bag =
    dict.combine(relevant_first, relevant_second, fn(a, b) { int.min(a, b) })
  MultiSet(bag:)
}

// A sum returns the sum of all the counts in two multisets
// ```
// a = {red: 3, blue: 2}
// b = {red: 1, blue: 1, green: 1}
// a + b = {red: 4, blue: 3, green: 1}
// ```
pub fn sum(of first: MultiSet(v), and second: MultiSet(v)) {
  let bag = dict.combine(first.bag, second.bag, fn(a, b) { a + b })
  MultiSet(bag:)
}

// A union (∪) returns the max count for each
// ```
// a = {red: 3, blue: 2}
// b = {red: 1, green: 4}
// a ∪ b = {red: 3, blue: 2, green: 4}
// ```
pub fn union(of first: MultiSet(v), and second: MultiSet(v)) {
  let bag = dict.combine(first.bag, second.bag, fn(a, b) { int.max(a, b) })
  MultiSet(bag:)
}

// Return the dictionary representing this MultiSet
pub fn to_dict(bag: MultiSet(v)) {
  bag.bag
}
