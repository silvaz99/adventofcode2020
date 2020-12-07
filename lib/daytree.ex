defmodule Daytree do

  def main do
    rows = process_input()
    [_head | tail] = rows

    tail
    |> Enum.map_reduce({0, 3}, fn x, {tree, col} -> {
      check_tree(x, {tree, col}),
      {tree, check_col(col)} }
    end)
    |> sum_trees()

  end

  def sum_trees({trees, {_, _}}) do
    Enum.sum(trees)
  end

  def check_tree(row, {tree, col}) do

    case String.at(row, col) do
      "#" -> tree + 1
      "." -> tree
    end
  end

  def check_col(col) do
    if col + 3 > 30 do
      rem(col + 3, 30) - 1
    else
      col + 3
    end
  end

  def process_input do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
  end

end
