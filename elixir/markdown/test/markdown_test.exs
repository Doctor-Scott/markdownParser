defmodule MarkdownTest do
  use ExUnit.Case
  doctest Markdown

  test "Normal string returns unchanged string" do
    assert Markdown.convert_to_html("Hello World!") == "Hello World!"
  end

  test "Tests expect valid markdown headers to return valid html header tags" do
    test_config = [
      ["# hello", "<h1>hello</h1>"],
      ["## hello", "<h2>hello</h2>"],
      ["### hello", "<h3>hello</h3>"],
      ["#### hello", "<h4>hello</h4>"]
    ]

    test_config
    |> Enum.each(fn config ->
      assert Markdown.convert_to_html(config |> Enum.at(0)) == config |> Enum.at(1)
    end)
  end

  test "Expect dodgy data to be unchanged" do
    assert Markdown.convert_to_html("##-- hello") == "##-- hello"
  end
end
