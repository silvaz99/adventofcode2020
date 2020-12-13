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

  def sum_fields(input) do

    #Enum.map(&Enum.sum(&1))
    variable = Stream.chunk_by(input, fn x -> x != 0 end)
    |> Enum.to_list()
    |> Enum.map(&Enum.sum(&1))
    |> Enum.count(fn number -> number >= 7 end)
    IO.puts(variable)


    variable
  end

  def group_passports(row) do

    list = String.split(row, " ", trim: true)
    Enum.reduce(list, 0,  fn fields, acc -> check_fields(fields, acc) end)

  end

  def check_fields(fields, acc) do
    [field, _rest ] = String.split(fields, ":", trim: true)
    #IO.puts(field)
    case field do
      "ecl" -> acc + 1
      "byr" -> acc + 1
      "iyr" -> acc + 1
      "eyr" -> acc + 1
      "hgt" -> acc + 1
      "pid" -> acc + 1
      "hcl" -> acc + 1
      "cid" -> acc + 0.5
       _ -> acc
    end


  end

  def get_input do
    File.read!("input.txt")
    |> String.split("\n")
  end
end
