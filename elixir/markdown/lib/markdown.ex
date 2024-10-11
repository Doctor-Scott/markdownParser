defmodule Markdown do
  import Enum

  @spec convert_to_html(String.t()) :: String.t()
  def convert_to_html(markdown_string) do
    markdown_string
    |> String.split("\n")
    |> map(&(&1 |> convert_line))
    |> join("\n")
  end

  defp convert_line(line, :heading) do
    heading_size = line |> String.split(" ") |> at(0) |> String.length()
    string = line |> String.slice((heading_size + 1)..-1)

    "<h#{heading_size}>#{string}</h#{heading_size}>"
  end

  defp convert_line(line, :none), do: line

  defp convert_line(line), do: convert_line(line, line |> interpret_line_type)

  # Match heading from first char of line
  defp interpret_line_type("#" <> _ = line), do: (valid_element?(line) && :heading) || :none

  defp interpret_line_type(_), do: :none

  defp valid_element?("#" <> _ = line) do
    chars_before_space =
      line
      |> String.split(" ")
      |> at(0)
      |> String.split("", trim: true)

    # This reduce works like an every() function
    all_hash_before_space? =
      chars_before_space
      |> reduce(true, &(&1 == "#" && &2))

    valid_length = length(chars_before_space) < 6

    valid_length && all_hash_before_space?
  end
end
