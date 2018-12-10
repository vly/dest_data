# lib/dest_data/fetch_json.ex

defmodule DestData.JSONFetch do
  use DestData.Constants
  
  alias __MODULE__
  alias DestData.Accounts

  @doc """
  `fetch` retrieves user history from username
  """
  
  def search_user(username) do
    Accounts.get_user(username)["Response"]
      |> hd()
      |> get_characters()
      |> get_activities()
      |> IO.inspect
  end

def retrieve_manifests() do
    get_manifests()
      |> elem(0) # ["mobileGearCDN"]
      |> Enum.map(fn ({name, manifest}) -> download_manifest(name, manifest) end)
  end
  
  def fetch(url) do
    headers = ["X-API-Key": @api_key, "User-agent": @user_agent] 
    response = url 
      |> HTTPoison.get(headers)
      |> case do
           {:ok, %{body: body, status_code: status_code}} -> {:ok, status_code, body}
           {:error, %{reason: reason}} -> {:error, reason, []}
         end
      |> parse_json
    
    response
      |> case do
           {:error, %{error: "sleep", message: message}} ->
             :timer.sleep(message * 1000)
             fetch(url)
           {:error, %{error: "retrieval", message: message}} -> {message}
           {:ok, %{data: data}} -> {data}
         end
  end
  
  defmodule APIresponse do
    @derive [Poison.Encoder]
    defstruct [:ErrorCode, :ErrorStatus, :Message, :MessageData, :Response, :ThrottleSeconds]
  end


  defp parse_json({:ok, status_code, body}) do

    {:ok, data} = Poison.decode(body, as: %APIresponse{})
    
    cond do
      data."ThrottleSeconds" > 0 -> {:error, %{error: "sleep", message: data."ThrottleSeconds"}}
      data."ErrorCode" > 1 -> {:error, %{error: "retrieval", message: data."ErrorStatus"}}
      data."ErrorCode" == 1 -> {:ok, %{data: data."Response"}}
    end
  end

  defp parse_json({:error, %{reason: reason}}) do
    IO.puts "Error in generating request"
    IO.puts reason
  end

  defp parse_json({_, %{status_code: status, body: body}}) do
    IO.puts "Error retrieving data: #{status}"
    IO.puts body
  end

  defp get_member(memberId) do
    defmodule Member do
      defstruct [:name]
    end
    "#{@endpoint}/User/GetMembershipsById/#{memberId}/-1/"
  end

  defp get_characters(user) do
    membershipType = user["membershipType"]
    memberId = user["membershipId"]
    "#{@endpoint}/Destiny2/#{membershipType}/Profile/#{memberId}/?components=characters"
      |> fetch
      |> elem(1)
  end

  defp get_activities(character) do
    character = character["Response"]["characters"]["data"]["2305843009393603767"]
    membershipType = character["membershipType"]
    destinyMembershipId = character["membershipId"]
    characterId = character["characterId"]

    "#{@endpoint}/Destiny2/#{membershipType}/Account/#{destinyMembershipId}/Character/#{characterId}/Stats/Activities/?count=100"
      |> fetch
      |> elem(1)
  end

  defp get_manifests() do
    "#{@endpoint}/Destiny2/Manifest/"
      |> fetch
  end

  defp download_manifest(name, manifest) do
    %HTTPoison.Response{body: body} = "https://www.bungie.net/#{manifest}"
      |> HTTPoison.get!()
    IO.puts "Downloaded #{name} manifest" 
    File.write("data/#{name}.content", body)
  end
end
