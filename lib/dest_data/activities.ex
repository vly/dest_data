# lib/dest_data/activities.ex

defmodule DestData.Activities do

  use DestData.Constants
  
  alias __MODULE__
  alias DestData.{
    JSONFetch,
    Utilities,
  }


  @doc """
  Methods for retrieving account/character activity details

  """
  defmodule Activity do
    defstruct [:activityDetails, :period, :values]
    def get(map, key, default), do: Map.get(map, key, default)
    def fetch(term, key), do: Map.fetch(term, key)
  end

  def get_activities(character, user, count \\ 100) do
    membershipType = user[:membershipType]
    destinyMembershipId = user[:membershipId]
    characterId = character[:characterId]

    "#{@endpoint}/Destiny2/#{membershipType}/Account/#{destinyMembershipId}/Character/#{characterId}/Stats/Activities/?count=#{count}"
    |> JSONFetch.fetch
    |> Map.get("activities")
    |> Enum.map(fn activity -> Utilities.key_to_atom(activity) end)
    |> Enum.map(fn activity -> Utilities.struct_pipe(activity, Activities.Activity) end)
  end
end
