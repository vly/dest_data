# lib/dest_data/manifests.ex

defmodule DestData.Manifests do
  import DestData
  @endpoint Application.get_env(:dest_data, :dest_endpoint)
  alias DestData.JSONFetch

  def retrieve_manifests() do
    get_manifests()
     |> elem(0)
     #|> Enum.reject(fn ({key, _}) -> key == 'version' end)
     |> flatten()
     |> IO.inspect
     |> Enum.map(fn ({name, manifest}) -> download_manifest(name, manifest) end)
    #download_manifest("zh-cht", "/common/destiny2_content/sqlite/zh-cht/world_sql_content_c4f0b2b59e142007176352883f6cbc56.content")
  end

  defp get_manifests() do
    "#{@endpoint}/Destiny2/Manifest/"
      |> JSONFetch.fetch
  end

  defp process_manifests() do
  end  

  defp download_manifest(name, manifest) do
    %HTTPoison.Response{body: body} = "https://www.bungie.net/#{manifest}"
      |> HTTPoison.get!()
    IO.puts "Downloaded #{name} manifest" 
    File.write("data/#{name}.content", body)
  end

  defp flatten(value, path \\ [])

  defp flatten(m, path) when is_map(m) do
    m
    |> Enum.flat_map(
      fn
        {k, v} when is_list(v) -> flatten(hd(v), path ++ [k]) 
        {k, v} when is_map(v) -> flatten(v, path ++ [k])
        {k, v} -> [{key(k, path), flatten(v, path ++ [k])}]
      end)
    |> Enum.into(%{})
  end

  defp flatten(value, _path) do
    value
  end

  defp key(key, path) do
    path ++ [key]
    |> Enum.join("_")
    |> String.to_atom
  end


end
