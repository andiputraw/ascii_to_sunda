# AsciiToSunda
Convert latin to sundaneese script.

Support both text and number. might be not accurate.

also does not consider "eu" and "é" as word on latin to string  

## Examples
```elixir
  iex> LatinToSunda.parse("bandung")
  "ᮘᮔ᮪ᮓᮥᮀ"
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ascii_to_sunda` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ascii_to_sunda, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ascii_to_sunda>.

