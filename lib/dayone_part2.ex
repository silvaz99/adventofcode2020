defmodule Dayone2 do

  import Dayone, only: [process_input: 0]

  def main() do

    list = Dayone.process_input()

    Enum.map(list, fn x -> sec_gen(list, x) end)
    |> Enum.max()
    |> Enum.max()

  end


  def sec_gen(list , head_sum) do

    list
    |> Enum.map(fn x -> test_sum(list, x, head_sum) end)

  end


  def test_sum(list, head_sum, sec) do
    list
    |> Enum.reduce(0, fn x, acc ->
        if x + head_sum + sec == 2020 do
          x * head_sum * sec
        else
          acc + 0
        end
      end)
  end

end
