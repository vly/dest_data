defmodule DestData do
  @moduledoc """
  Destiny 2 API client and CLI application.

  Requires a valid Destiny API key to be set in config file `config/dev.secret.exs`
  
  * `api_key` - Your Destiny 2 API key

  Usage for CLI application:

  ```
    usage: dest_data <command> [options]

    commands:
      accounts      Get account scope data
      manifests     Retrieve latest game manifests from Bungie
      scrape        Initiate a recursive data scrape

  """
end
