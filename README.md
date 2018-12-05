# Destiny 2 API scraper

## Overview

This is a data retrieval scraper to pull Destiny 2 player player data, their state, and activity history among others.
It's purpose written for a specific use-case (generate timeseries data for retention analysis) but can be utilised for other purposes.

## Quickstart

Retrieve a user's characters including light, and base stats:

```
./dest_data user plasticmice
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `dest_data` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:dest_data, "~> 0.1.0"}
  ]
end
```

## Development

### Building
```
mix deps.get
mix escript.build
```

### Running tests
```
mix test
```

### Running dialyzer
```
mix dialyzer
```
