defmodule ParallelismReportsChallenge do
  alias ParallelismReportsChallenge.Parser

  @months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @user_list [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Rafael",
    "Vinicius",
    "Danilo"
  ]

  def call(file_name) do
    file_name
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report ->
      sum_hours(line, report)
    end)
  end

  def build_from_many(files_names) when not is_list(files_names),
    do: {:error, "Please provide a list of strings"}

  def build_from_many(files_names) do
    result =
      files_names
      |> Task.async_stream(&call/1)
      |> Enum.reduce(report_acc(), fn {:ok, result}, report ->
        sum_reports(report, result)
      end)

    {:ok, result}
  end

  def sum_reports(
        %{
          "all_hours" => all_hours_a,
          "hours_per_month" => hours_per_month_a,
          "hours_per_year" => hours_per_year_a
        },
        %{
          "all_hours" => all_hours_b,
          "hours_per_month" => hours_per_month_b,
          "hours_per_year" => hours_per_year_b
        }
      ) do
    all_hours = merge_maps(all_hours_a, all_hours_b)
    hours_per_month = merge_maps(hours_per_month_a, hours_per_month_b)
    hours_per_year = merge_maps(hours_per_year_a, hours_per_year_b)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp sum_hours([name, quantity, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do

    all_hours = Map.put(all_hours, name, all_hours[name] + quantity)

    hours_per_month =
      Map.put(
        hours_per_month,
        name,
        put_sub_maps(hours_per_month[name], set_month(month), quantity)
      )

    hours_per_year =
      Map.put(hours_per_year, name, put_sub_maps(hours_per_year[name], year, quantity))

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_maps(map_a, map_b) do
    Map.merge(map_a, map_b, fn _key, value_a, value_b ->
      case is_map(value_a) and is_map(value_b) do
        true -> merge_maps(value_a, value_b)
        false -> value_a + value_b
      end
    end)
  end

  defp put_sub_maps(map, key, quantity) do
    Map.put(map, key, map[key] + quantity)
  end

  defp set_month(number_month) do
    case number_month in 1..12 do
      true -> Enum.at(@months, number_month - 1)
      _ -> {:error, "Month invalid"}
    end
  end

  defp report_acc do
    months = Enum.into(@months, %{}, &{&1, 0})
    years = Enum.into(2016..2020, %{}, &{&1, 0})

    all_hours = Enum.into(@user_list, %{}, &{&1, 0})
    hours_per_month = Enum.into(@user_list, %{}, &{&1, months})
    hours_per_year = Enum.into(@user_list, %{}, &{&1, years})

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
