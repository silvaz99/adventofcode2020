defmodule Daytwo do

  def main do

    rows = get_input()

    Enum.map(rows, fn x -> count_valid(x) end)
    |> Enum.sum()

  end

  def count_valid(row) do
    [ numbers , letter | password ] = String.split(row, " ", trim: true)

    [ min , max ] = String.split(numbers, "-", trim: true)
    |> Enum.map(&String.to_integer/1)

    chars_counted = count_letter(String.first(letter), password)

    case chars_counted <= max and chars_counted >= min do
      true -> 1
      false -> 0
    end

  end

  def count_letter(letter, password) do
    List.to_string(password)
    |> String.codepoints()
    |> Enum.reduce(0, fn x, acc ->
        case x == letter do
          true -> acc + 1
          false -> acc
        end
      end)
  end

  def get_input do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
  end

end
