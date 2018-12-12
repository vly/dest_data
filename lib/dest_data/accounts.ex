defmodule DestData.Accounts do

  use DestData.Constants

  alias __MODULE__
  alias DestData.{
    JSONFetch,
    Utilities,
    Activities,
  }
  
  @doc """
  Retrieve account scope data from Bungie and Destiny specific endpoints.
  """

  defmodule User do
      defstruct [:displayName, :iconPath, :membershipId, :membershipType]
      def get(map, key, default), do: Map.get(map, key, default)
      def fetch(term, key), do: Map.fetch(term, key)
    end

  def get_member(memberId) do
    defmodule Member do
      defstruct [:name]
    end
    "#{@endpoint}/User/GetMembershipsById/#{memberId}/-1/"
  end

  def get_user(username) do
    
    "#{@endpoint}/Destiny2/SearchDestinyPlayer/2/#{username}/"
    |> JSONFetch.fetch
    |> hd()
    |> Utilities.key_to_atom()
    |> Utilities.struct_pipe(User)
  end

  def get_characters(user) do
    IO.inspect(user)
    membershipType = Map.get(user, :membershipType)
    memberId = Map.get(user, :membershipId)
    "#{@endpoint}/Destiny2/#{membershipType}/Profile/#{memberId}/?components=characters"
    |> JSONFetch.fetch
    |> process_characters()
    |> Enum.map( fn character -> Activities.get_activities(character, user) end)
    |> IO.inspect
  end

  def search_user(username) do
    Accounts.get_user(username)
      |> Accounts.get_characters()
  end  

  defp process_characters(data) do

    defmodule Character do
      defstruct [:characterId, :classHash, :classType, :dateLastPlayed, :baseCharacterLevel, 
        :genderHash, :genderType, :levelProgression, :light, :minutesPlayedThisSession,
        :minutesPlayedTotal, :percentToNextLevel, :raceHash, :raceType, :stats]
      def get(map, key, default), do: Map.get(map, key, default)
      def fetch(term, key), do: Map.fetch(term, key)
    end 

    data["characters"]["data"]
    |> Enum.map(fn {_, v} -> Utilities.key_to_atom(v) end)
    |> Enum.map( fn v -> Utilities.struct_pipe(v, Accounts.Character) end)
    

  end
end
