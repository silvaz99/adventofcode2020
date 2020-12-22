defmodule Dayfour do

  def main do
    rows = get_input()

    rows
    |> Enum.map(fn x -> group_passports(x) end)
    |> Stream.chunk_by(fn x -> x != 0 end)
    |> Enum.to_list()
    |> Enum.map(&Enum.sum(&1))
    |> Enum.count(fn number -> number >= 7 end)

  end

  def group_passports(row) do

    list = String.split(row, " ", trim: true)
    Enum.reduce(list, 0,  fn fields, acc -> check_fields(fields, acc) end)

  end

  def check_fields(fields, acc) do
    [field, value ] = String.split(fields, ":", trim: true)

    case field do
      "ecl" -> check_ecl(value, acc)
      "byr" -> check_year(value, acc, 1920, 2020)
      "iyr" -> check_year(value, acc, 2010, 2020)
      "eyr" -> check_year(value, acc, 2020, 2030)
      "hgt" -> check_hgt(value, acc)
      "pid" -> check_pid(value, acc)
      "hcl" -> check_hcl(value, acc)
      "cid" -> acc + 0.5
       _ -> acc
    end


  end

  def check_year(value, acc, min, max) do
    year = String.to_integer(value)
    if year >= min and year <= max and String.length(value) == 4 do
      acc + 1
    else
      acc
    end
  end


  def check_ecl(value, acc) do
    case value do
      "amb" -> acc + 1
      "blu" -> acc + 1
      "brn" -> acc + 1
      "gry" -> acc + 1
      "grn" -> acc + 1
      "hzl" -> acc + 1
      "oth" -> acc + 1
      _ -> acc
    end
  end

  def check_hgt(value, acc) do
    case {String.contains?(value, "in"), String.contains?(value, "cm")} do
      {true, false} -> check_hgt_in(value, acc)
      {false, true} -> check_hgt_cm(value, acc)
      _ -> acc
    end
  end

  def check_hgt_in(value, acc) do
    [ numbers, _in ] = String.split(value, "in")
    height = String.to_integer(numbers)
    check_height(height, acc, 59, 76)
  end

  def check_hgt_cm(value, acc) do
    [ numbers, _cm ] = String.split(value, "cm")
    height = String.to_integer(numbers)
    check_height(height, acc, 150, 193)
  end

  def check_height(height, acc, min, max) do
    if height >= min and height <= max do
      acc + 1
    else
      acc
    end
  end

  def check_pid(value, acc) do
    case {String.match?(value, ~r/^[0-9]+$/), String.length(value) == 9} do
      {true, true} -> acc + 1
      _ -> acc
    end
  end

  def check_hcl(value, acc) do
    { hash, rest } = String.split_at(value, 1)
    if String.length(rest) == 6 do
      case hash do
        "#" -> check_hair_color(rest, acc)
        _ -> acc
      end
    else
      acc
    end

  end

  def check_hair_color(rest, acc) do

    case String.match?(rest, ~r/^[a-f0-9]+$/) do
      true -> acc + 1
      _ -> acc
    end

  end

  def get_input do
    File.read!("input.txt")
    |> String.split("\n")
  end
end
