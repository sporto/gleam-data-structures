import gleam/set
import multimap as mm

pub fn get_test() {
  let actual = mm.new() |> mm.insert("a", 1) |> mm.get("a")
  assert actual == set.from_list([1])
}

pub fn get_val_test() {
  let actual = mm.new() |> mm.insert("a", 1) |> mm.get_val(1)
  assert actual == set.from_list(["a"])
}

pub fn delete_test() {
  let m =
    mm.new()
    |> mm.insert("a", 1)
    |> mm.insert("a", 2)
    |> mm.insert("b", 1)
    |> mm.delete("a")

  assert mm.get(m, "a") == set.new()
  assert mm.get_val(m, 2) == set.new()
  assert mm.get_val(m, 1) == set.from_list(["b"])
}

pub fn delete_val_test() {
  let m =
    mm.new()
    |> mm.insert("a", 1)
    |> mm.insert("a", 2)
    |> mm.insert("b", 1)
    |> mm.delete_val(1)

  assert mm.get_val(m, 1) == set.new()
  assert mm.get(m, "a") == set.from_list([2])
  assert mm.get(m, "b") == set.new()
}

pub fn delete_key_val_test() {
  let m =
    mm.new()
    |> mm.insert("a", 1)
    |> mm.insert("a", 2)
    |> mm.insert("b", 1)
    |> mm.delete_key_val("a", 2)

  assert mm.get(m, "a") == set.from_list([1])
}
