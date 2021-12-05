defmodule Aoc do
  def puzzle_input do
    {:ok, file_contents } = File.read("input_test_03.txt")
    String.split(file_contents, "\n", trim: true)
    |> Enum.map(fn x -> String.split(x, "", trim: true) 
    |> Enum.map(fn y -> String.to_integer(y) end) end)
    |> Enum.map(fn x -> List.to_tuple(x) end)
  end

  def btoa(bits) do
    bits_count = tuple_size(bits) - 1
    Enum.reduce(bits_count..0, 0, fn i, acc -> 
      elem(bits, bits_count - i) * :math.pow(2, i) + acc 
    end)
  end

  def count(values, pos) do
    Enum.reduce(values, 0, fn penta, acc ->
      if elem(penta, pos) == 1 do
        acc + 1
      else
        acc
      end
    end)
  end

  def gamma(values) do
    most_common = div(Enum.count(values), 2)
    size = tuple_size(Enum.at(values, 0)) - 1
    Enum.map(0..(size), fn(pos) -> 
      if count(values, pos) > most_common do
        1
      else
        0
      end
    end)
    |> List.to_tuple
  end

  def epsilon(values) do
    gamma(values)
    |> Tuple.to_list
    |> Enum.map(fn
      1 -> 0
      0 -> 1
    end)
    |> List.to_tuple
  end

  def task do
    input = puzzle_input()
    btoa(gamma(input)) * btoa(epsilon(input))
  end
end
