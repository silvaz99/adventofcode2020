defmodule Dayone do

  def main() do

    list = process_input()

    Enum.map(list, fn x -> test_sum(list, x) end)
    |> Enum.max()
  end

  def process_input() do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end

  def test_sum(list, head) do
    list
    |> Enum.reduce(0, fn x, acc ->
        if x + head == 2020 do
          x * head
        else
          acc + 0
        end
      end)
  end


end
