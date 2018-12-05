# lib/dest_data/storage.ex

defmodule DestData.Storage do
  import DestData

  @doc """
  Contains options for data storage for scrapper functionality of `dest_data`

  Currently supported options are:

  * Flatfile (csv)
  * SQLite3
  * Postgres

  For production-esk environments, Postgres is recommended.
  """
end
