import structures/multiset as ms

pub fn modify_test() {
  let a =
    ms.new()
    |> ms.modify("red", 2)

  assert ms.get(a, "red") == 2

  let b =
    ms.new()
    |> ms.modify("red", 2)
    |> ms.modify("red", -1)

  assert ms.get(b, "red") == 1

  let c =
    ms.new()
    |> ms.modify("red", -1)

  assert ms.get(c, "red") == 0
}

pub fn difference_test() {
  let a =
    ms.new()
    |> ms.modify("red", 2)
    |> ms.insert("green")

  let b =
    ms.new()
    |> ms.insert("red")
    |> ms.insert("blue")

  let c = ms.difference(a, b)

  assert ms.get(c, "red") == 1
  assert ms.get(c, "blue") == 0
  assert ms.get(c, "green") == 1
}

pub fn intersection_test() {
  let a =
    ms.new()
    |> ms.modify("red", 2)
    |> ms.insert("green")

  let b =
    ms.new()
    |> ms.insert("red")
    |> ms.insert("blue")

  let c = ms.intersection(a, b)

  assert ms.get(c, "red") == 1
  assert ms.get(c, "blue") == 0
  assert ms.get(c, "green") == 0
}

pub fn sum_test() {
  let a =
    ms.new()
    |> ms.modify("red", 3)
    |> ms.modify("blue", 2)

  let b =
    ms.new()
    |> ms.insert("red")
    |> ms.insert("blue")
    |> ms.insert("green")

  let c = ms.sum(a, b)

  assert ms.get(c, "red") == 4
  assert ms.get(c, "blue") == 3
  assert ms.get(c, "green") == 1
}

pub fn union_test() {
  let a =
    ms.new()
    |> ms.modify("red", 3)
    |> ms.modify("blue", 2)

  let b =
    ms.new()
    |> ms.modify("red", 1)
    |> ms.modify("blue", 2)
    |> ms.modify("green", 4)

  let c = ms.union(a, b)

  assert ms.get(c, "red") == 3
  assert ms.get(c, "blue") == 2
  assert ms.get(c, "green") == 4
}
