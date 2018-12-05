# lib/dest_data/cli.ex

defmodule DestData.CLI do
  def main(args) do
    parse_args(args)
    |> process
  end

  def parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean], 
                             aliases: [h: :help])
    case parse do
      {[help: true], _}                           -> :help
      {_, [command], [key: key, val: val]}        -> {String.to_atom(command), key, val}
      {[], [command, param], _}                   -> {String.to_atom(command), param}
      {[], [command, param, param2], _}           -> {String.to_atom(command), param, param2}
      {[], [command], _}                          -> String.to_atom(command)
      _                                           -> :help
    end
  end

  def process(:manifests) do
    DestData.Manifests.retrieve_manifests()
  end

  def process({:users, param}) do
    DestData.JSONFetch.search_user(param)
  end

  def process(:users) do
    process(:help)
    IO.puts "Error: Specify a user to retrieve data for."
  end

  def process({:activities, param, param2}) do
    DestData.Activities.get_activities(param, param2)
  end

  def process(:scrape) do
    IO.puts "Scraping like a boss"
  end

  def process(:help) do
    IO.puts """
    Data grab
    ---------
    usage: dest_data <command> [options]

    commands:
      users         Get account and character information.
      manifests     Retrieve game manifests and store in data directory
      activity      Get activity history for specific character
      scrape        Start recursive scrapper

    example: dest_data users plasticmice
    """
  end
end

