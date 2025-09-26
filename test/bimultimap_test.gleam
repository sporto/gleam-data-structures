import bimultimap as bmm
import gleam/set

pub fn get_test() {
  let actual = bmm.new() |> bmm.insert("a", 1) |> bmm.get("a")
  assert actual == set.from_list([1])
}

pub fn get_val_test() {
  let actual = bmm.new() |> bmm.insert("a", 1) |> bmm.get_val(1)
  assert actual == set.from_list(["a"])
}

pub fn delete_test() {
  let m =
    bmm.new()
    |> bmm.insert("a", 1)
    |> bmm.insert("a", 2)
    |> bmm.insert("b", 1)
    |> bmm.delete("a")

  assert bmm.get(m, "a") == set.new()
  assert bmm.get_val(m, 2) == set.new()
  assert bmm.get_val(m, 1) == set.from_list(["b"])
}

pub fn delete_val_test() {
  let m =
    bmm.new()
    |> bmm.insert("a", 1)
    |> bmm.insert("a", 2)
    |> bmm.insert("b", 1)
    |> bmm.delete_val(1)

  assert bmm.get_val(m, 1) == set.new()
  assert bmm.get(m, "a") == set.from_list([2])
  assert bmm.get(m, "b") == set.new()
}

pub fn delete_key_val_test() {
  let m =
    bmm.new()
    |> bmm.insert("a", 1)
    |> bmm.insert("a", 2)
    |> bmm.insert("b", 1)
    |> bmm.delete_key_val("a", 2)

  assert bmm.get(m, "a") == set.from_list([1])
}
