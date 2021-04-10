defmodule ParallelismReportsChallengeTest do
  use ExUnit.Case

  describe "call/1" do
    test "call the report" do
      file_name = "test.csv"

      response = ParallelismReportsChallenge.call(file_name)

      expected_response = %{
        "all_hours" => %{
          "Cleiton" => 12,
          "Daniele" => 21,
          "Danilo" => 6,
          "Diego" => 7,
          "Giuliano" => 14,
          "Jakeliny" => 14,
          "Joseph" => 3,
          "Mayk" => 19,
          "Rafael" => 0,
          "Vinicius" => 0
        },
        "hours_per_month" => %{
          "Cleiton" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 4,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 8,
            "setembro" => 0
          },
          "Daniele" => %{
            "abril" => 7,
            "agosto" => 0,
            "dezembro" => 5,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 1,
            "maio" => 8,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Danilo" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 6,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Diego" => %{
            "abril" => 0,
            "agosto" => 4,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 3
          },
          "Giuliano" => %{
            "abril" => 1,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 9,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 4,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Jakeliny" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 8,
            "junho" => 0,
            "maio" => 0,
            "março" => 6,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Joseph" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 0,
            "março" => 3,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Mayk" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 5,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 7,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 7
          },
          "Rafael" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          },
          "Vinicius" => %{
            "abril" => 0,
            "agosto" => 0,
            "dezembro" => 0,
            "fevereiro" => 0,
            "janeiro" => 0,
            "julho" => 0,
            "junho" => 0,
            "maio" => 0,
            "março" => 0,
            "novembro" => 0,
            "outubro" => 0,
            "setembro" => 0
          }
        },
        "hours_per_year" => %{
          "Cleiton" => %{2016 => 3, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 9},
          "Daniele" => %{2016 => 10, 2017 => 3, 2018 => 7, 2019 => 0, 2020 => 1},
          "Danilo" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 6, 2020 => 0},
          "Diego" => %{2016 => 3, 2017 => 4, 2018 => 0, 2019 => 0, 2020 => 0},
          "Giuliano" => %{2016 => 0, 2017 => 3, 2018 => 0, 2019 => 6, 2020 => 5},
          "Jakeliny" => %{2016 => 0, 2017 => 8, 2018 => 0, 2019 => 6, 2020 => 0},
          "Joseph" => %{2016 => 0, 2017 => 3, 2018 => 0, 2019 => 0, 2020 => 0},
          "Mayk" => %{2016 => 7, 2017 => 8, 2018 => 0, 2019 => 4, 2020 => 0},
          "Rafael" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 0},
          "Vinicius" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 0}
        }
      }

      assert response == expected_response
    end
  end

  describe "build_from_many/1" do
    test "when list is provided, build the report" do
      file_names = ["test_1.csv", "test_2.csv", "test_3.csv"]

      response = ParallelismReportsChallenge.build_from_many(file_names)

      expected_response =
        {:ok,
         %{
           "all_hours" => %{
             "Cleiton" => 36,
             "Daniele" => 63,
             "Danilo" => 18,
             "Diego" => 21,
             "Giuliano" => 42,
             "Jakeliny" => 42,
             "Joseph" => 9,
             "Mayk" => 57,
             "Rafael" => 0,
             "Vinicius" => 0
           },
           "hours_per_month" => %{
             "Cleiton" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 12,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 24,
               "setembro" => 0
             },
             "Daniele" => %{
               "abril" => 21,
               "agosto" => 0,
               "dezembro" => 15,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 3,
               "maio" => 24,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Danilo" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 18,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Diego" => %{
               "abril" => 0,
               "agosto" => 12,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 9
             },
             "Giuliano" => %{
               "abril" => 3,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 27,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 12,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Jakeliny" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 24,
               "junho" => 0,
               "maio" => 0,
               "março" => 18,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Joseph" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 9,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Mayk" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 15,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 21,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 21
             },
             "Rafael" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             },
             "Vinicius" => %{
               "abril" => 0,
               "agosto" => 0,
               "dezembro" => 0,
               "fevereiro" => 0,
               "janeiro" => 0,
               "julho" => 0,
               "junho" => 0,
               "maio" => 0,
               "março" => 0,
               "novembro" => 0,
               "outubro" => 0,
               "setembro" => 0
             }
           },
           "hours_per_year" => %{
             "Cleiton" => %{2016 => 9, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 27},
             "Daniele" => %{2016 => 30, 2017 => 9, 2018 => 21, 2019 => 0, 2020 => 3},
             "Danilo" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 18, 2020 => 0},
             "Diego" => %{2016 => 9, 2017 => 12, 2018 => 0, 2019 => 0, 2020 => 0},
             "Giuliano" => %{2016 => 0, 2017 => 9, 2018 => 0, 2019 => 18, 2020 => 15},
             "Jakeliny" => %{2016 => 0, 2017 => 24, 2018 => 0, 2019 => 18, 2020 => 0},
             "Joseph" => %{2016 => 0, 2017 => 9, 2018 => 0, 2019 => 0, 2020 => 0},
             "Mayk" => %{2016 => 21, 2017 => 24, 2018 => 0, 2019 => 12, 2020 => 0},
             "Rafael" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 0},
             "Vinicius" => %{2016 => 0, 2017 => 0, 2018 => 0, 2019 => 0, 2020 => 0}
           }
         }}

      assert response == expected_response
    end

    test "when a file list is not provided, returns an error" do
      file_names = "invalid"

      response = ParallelismReportsChallenge.build_from_many(file_names)

      expected_response = {:error, "Please provide a list of strings"}

      assert response == expected_response
    end
  end
end
