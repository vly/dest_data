# lib/dest_data/manifests.ex

defmodule DestData.Manifests do
  import DestData
  @endpoint Application.get_env(:dest_data, :dest_endpoint)
  alias DestData.JSONFetch

  def retrieve_manifests() do
    #get_manifests()
     # |> elem(0)
      #|> IO.puts
      #|> Enum.map(fn ({name, manifest}) -> download_manifest(name, manifest) end)
    download_manifest("zh-cht", "/common/destiny2_content/sqlite/zh-cht/world_sql_content_c4f0b2b59e142007176352883f6cbc56.content")
  end

  defp get_manifests() do
    "#{@endpoint}/Destiny2/Manifest/"
      |> JSONFetch.fetch
  end

  defp download_manifest(name, manifest) do
    %HTTPoison.Response{body: body} = "https://www.bungie.net/#{manifest}"
      |> HTTPoison.get!()
    IO.puts "Downloaded #{name} manifest" 
    File.write("data/#{name}.content", body)
  end


end
