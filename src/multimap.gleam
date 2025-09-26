import gleam/dict.{type Dict}
import gleam/option.{None, Some}
import gleam/result
import gleam/set.{type Set}

pub opaque type Multimap(k, v) {
  Multimap(direct: Dict(k, Set(v)), reverse: Dict(v, Set(k)))
}

pub fn new() {
  Multimap(direct: dict.new(), reverse: dict.new())
}

pub fn insert(into into: Multimap(k, v), key key: k, value value: v) {
  let direct =
    dict.upsert(into.direct, key, fn(option) {
      case option {
        None -> set.from_list([value])
        Some(existing) -> set.insert(existing, value)
      }
    })
  let reverse =
    dict.upsert(into.reverse, value, fn(option) {
      case option {
        None -> set.from_list([key])
        Some(existing) -> set.insert(existing, key)
      }
    })
  Multimap(direct:, reverse:)
}

pub fn get(from from: Multimap(k, v), key key: k) -> Set(v) {
  dict.get(from.direct, key) |> result.unwrap(set.new())
}

pub fn get_val(from from: Multimap(k, v), value value: v) -> Set(k) {
  dict.get(from.reverse, value)
  |> result.unwrap(set.new())
}

pub fn delete(from from: Multimap(k, v), key key: k) {
  let values = get(from, key)
  let direct = dict.delete(from.direct, key)

  let reverse =
    set.fold(values, from.reverse, fn(acc, value) {
      dict.upsert(acc, value, fn(option) {
        case option {
          None -> set.new()
          Some(existing) -> set.delete(existing, key)
        }
      })
    })

  Multimap(direct:, reverse:)
}

pub fn delete_val(from from: Multimap(k, v), value value: v) {
  let keys = get_val(from, value)
  let reverse = dict.delete(from.reverse, value)

  let direct =
    set.fold(keys, from.direct, fn(acc, key) {
      dict.upsert(acc, key, fn(option) {
        case option {
          None -> set.new()
          Some(existing) -> set.delete(existing, value)
        }
      })
    })

  Multimap(direct:, reverse:)
}
