defmodule HydrothermalVents do
  def lines do
    {:ok, file_contents } = File.read("input_day_05.txt")
    String.split(file_contents, "\n", trim: true)
    |> Enum.map(fn line -> 
      [start_point, end_point] = String.split(line, " -> ", trim: true) 
      |> Enum.map(fn point ->
        [x, y] = String.split(point, ",", trim: true)
        |> Enum.map(fn str -> String.to_integer(str) end)
        { x, y }
      end)
      { start_point, end_point }
    end)
  end

  def filter(lines) do
    Enum.filter(lines, fn { {x1, y1}, {x2, y2} } ->
      x1 == x2 || y1 == y2
    end)
  end

  def line_extrapolation({ {x1, y1}, {x2, y2} }) when x1 == x2 do
    Enum.map(y1..y2, fn y -> { x1, y } end)
  end

  def line_extrapolation({ {x1, y1}, {x2, y2} }) when y1 == y2 do
    Enum.map(x1..x2, fn x -> { x, y1 } end)
  end

  def line_extrapolation({ {x1, y1}, {x2, y2} }) do
    positive_difference = trunc :math.sqrt((x1 - x2) * (x1 - x2))
    Enum.map(0..positive_difference, fn i ->
      {
        Enum.at(x1..x2, i),
        Enum.at(y1..y2, i)
      }
    end)
  end

  def count_overlaps do
    Enum.flat_map(lines, &HydrothermalVents.line_extrapolation/1)
    |> Enum.group_by(fn x -> x end)
    |> Map.values
    |> Enum.filter(fn points -> Enum.count(points) >= 2 end)
    |> Enum.count
  end
end
