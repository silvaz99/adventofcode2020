defmodule Daytwo do

  def main do

    rows = get_input()

    Enum.map(rows, fn x -> count_valid(x) end)
    |> Enum.sum()

  end

  def main_pt2 do

    rows = get_input()

    Enum.map(rows, fn x -> count_valid_pt2(x) end)
    |> Enum.sum()

  end

  def count_valid_pt2(row) do
    [ numbers , letter_with_colon , password ] = String.split(row, " ", trim: true)

    [ min, max ] = get_min_max(numbers)

    letter = String.first(letter_with_colon)


    if check_one_logic_part(password, min, max, letter) and check_two_logic_part(password, min, max, letter)  do
      1
    else
      0
    end
  end

  def check_one_logic_part(password, min, max, letter) do
    if String.at(password, min - 1) == letter or String.at(password, max - 1) == letter do
      true
    else
      false
    end
  end

  def check_two_logic_part(password, min, max, letter) do
    if not (String.at(password, min - 1) == letter) or not (String.at(password, max - 1) == letter) do
      true
    else
      false
    end

  end

  def get_min_max(numbers) do

    String.split(numbers, "-", trim: true)
    |> Enum.map(&String.to_integer/1)

  end

  def count_valid(row) do
    [ numbers , letter | password ] = String.split(row, " ", trim: true)

    [ min , max ] = get_min_max(numbers)

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
