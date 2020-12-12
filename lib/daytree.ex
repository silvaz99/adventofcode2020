defmodule Daytree do

  def main do
    rows = process_input()
    [_head | tail] = rows

    list = [{0, 1}, {0, 3}, {0, 5}, {0, 7}]

    partial_result = Enum.map(list, fn {x, y} -> idontknow({x, y}, tail) end)
    |> Enum.reduce(fn x, acc -> x * acc end)

    new_rows = Enum.drop_every(tail, 2)

    every_two = Enum.map([{0,1}], fn {x, y} -> idontknow({x, y}, new_rows) end)
    |> Enum.sum()

    partial_result * every_two

  end


  def idontknow({initial_x, initial_y}, tail) do
    tail
    |> Enum.map_reduce({initial_x, initial_y}, fn x, {tree, col} -> {
      check_tree(x, {tree, col}),
      {tree, check_col(col, initial_y)} }
    end)
    |> sum_trees()
  end

  def sum_trees({trees, {_, _}}) do
    IO.puts(Enum.sum(trees))
    Enum.sum(trees)
  end

  def check_tree(row, {tree, col}) do

    case String.at(row, col) do
      "#" -> tree + 1
      "." -> tree
    end
  end

  def check_col(col, step) do
    if col + step > 30 do
      rem(col + step, 30) - 1
    else
      col + step
    end
  end

  def process_input do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
  end

end
