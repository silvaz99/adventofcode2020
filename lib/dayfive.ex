defmodule Dayfive do

  def main do
    rows = get_input()

    Enum.map(rows, fn row -> process_row(row) end)
    |> Enum.max()
  end

  def process_row(row) do
    { line , columns } = String.split_at(row, 7)

    { min, max } = Enum.reduce(String.codepoints(line), {0, 127}, fn char, { min, max } ->
      case char do
        "B" -> {ceil(min + (max - min)/2), max}
        "F" -> {min, trunc(min + (max - min)/2)}
      end
    end)

    { lower, upper } = Enum.reduce(String.codepoints(columns), {0, 7}, fn char, { min, max } ->
      case char do
        "R" -> {ceil(min + (max - min)/2), max}
        "L" -> {min, trunc(min + (max - min)/2)}
      end
    end)

    case min == max and lower == upper do
      true -> max * 8 + lower
      _ -> 0
    end

  end

  def get_input() do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
  end
end
