defmodule Markdown do
  import Enum

  @spec convert_to_html(String.t()) :: String.t()
  def convert_to_html(markdown_string), do: split_convert_join(markdown_string)

  defp split_convert_join(markdown_string) do
    markdown_string
    |> String.split("\n")
    |> map(&(&1 |> convert_line))
    |> join("\n")
  end

  defp convert_line("# " <> string), do: "<h1>#{string}</h1>"
  defp convert_line("## " <> string), do: "<h2>#{string}</h2>"
  defp convert_line("### " <> string), do: "<h3>#{string}</h3>"
  defp convert_line("#### " <> string), do: "<h4>#{string}</h4>"
  defp convert_line("##### " <> string), do: "<h5>#{string}</h5>"
  defp convert_line("###### " <> string), do: "<h6>#{string}</h6>"
  defp convert_line(line), do: line
end
