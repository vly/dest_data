# lib/dest_data/storage.ex

defmodule DestData.Storage do

  alias __MODULE__

  @doc """
  Contains options for data storage for scrapper functionality of `dest_data`

  Currently supported options are:

  * Flatfile (csv)
  * SQLite3
  * Postgres
  * Neo4j
  * Google BigQuery

  For production-esk environments, Postgres is recommended.
  """

  def write_csv(filepath, data) do
  end

  def write_sqlite(dbpath, data) do
  end

  def write_postgres(dbconn, data) do
  end

  def write_neo4j(dbconn, data) do
  end

  def write_bq(dbconn, data) do
  end

end
