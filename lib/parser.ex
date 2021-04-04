defmodule ParallelismReportsChallenge.Parse do
  def parse_file(file_name) do
    "reports/#{file_name}"
    |> File.stream!()
    |> Stream.map(&parse_line(&1))
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&string_to_integer/1)
  end

  defp string_to_integer(string) do
    case Integer.parse(string) do
      {value, _string} -> value
      :error -> string
    end
  end
end
