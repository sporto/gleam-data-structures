import structures/bimap as bm

pub fn insert_same_key_test() {
  let m =
    bm.new()
    |> bm.insert("a", 1)
    |> bm.insert("a", 2)

  assert bm.get(m, "a") == Ok(2)
  assert bm.get_val(m, 2) == Ok("a")
  assert bm.get_val(m, 1) == Error(Nil)
}

pub fn insert_same_value_test() {
  let m =
    bm.new()
    |> bm.insert("a", 1)
    |> bm.insert("b", 1)

  assert bm.get(m, "b") == Ok(1)
  assert bm.get(m, "a") == Error(Nil)
  assert bm.get_val(m, 1) == Ok("b")
}

pub fn delete_test() {
  let m =
    bm.new()
    |> bm.insert("b", 1)
    |> bm.delete("b")

  assert bm.get(m, "b") == Error(Nil)
  assert bm.get_val(m, 1) == Error(Nil)
}

pub fn delete_val_test() {
  let m =
    bm.new()
    |> bm.insert("b", 1)
    |> bm.delete_val(1)

  assert bm.get(m, "b") == Error(Nil)
  assert bm.get_val(m, 1) == Error(Nil)
}
