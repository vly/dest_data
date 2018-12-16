# lib/dest_data/activities.ex

defmodule DestData.Activities do

  use DestData.Constants
  
  #alias __MODULE__
  alias DestData.{
    JSONFetch,
    Utilities,
    Types,
  }


  @doc """
  Methods for retrieving account/character activity details

  """

  def get_activities(character, user, count \\ 250) do
    membershipType = user[:membershipType]
    destinyMembershipId = user[:membershipId]
    characterId = character[:characterId]

    "#{@endpoint}/Destiny2/#{membershipType}/Account/#{destinyMembershipId}/Character/#{characterId}/Stats/Activities/?count=#{count}"
    |> JSONFetch.fetch
    |> Map.get("activities")
    |> Utilities.process_response(Types.Activity) 
  end

  def get_story_activities(character, user, count \\ 250) do
    # Retrieves story history for a given character. Oldest entry is used
    # as a proxy for character creation timestamp, while last played from User object the last. 
    # Extrapolated to account level when min'd across all characters.
    membershipType = user[:membershipType]
    destinyMembershipId = user[:membershipId]
    characterId = character[:characterId]

    "#{@endpoint}/Destiny2/#{membershipType}/Account/#{destinyMembershipId}/Character/#{characterId}/Stats/Activities/?count=#{count}&mode=2"
    |> JSONFetch.fetch
    |> Map.get("activities")
    |> Utilities.process_response(Types.Character) 
  end

  defp process_output(response) do
    # Process activities response to tabular format.
    # Most likely will make this a generic function to flatten to a 2d array structure (ala dataframe)
    IO.inspect response
  end

end
