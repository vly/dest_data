# lib/dest_data/activities.ex

defmodule DestData.Activities do

  use DestData.Constants
  
  alias __MODULE__
  alias DestData.JSONFetch

  @doc """
  Methods for retrieving account/character activity details

  """


  def get_activities(character, user) do
    characteddr = Character["Response"]["characters"]["data"]["2305843009393603767"]
    membershipType = Character["membershipType"]
    destinyMembershipId = Character["membershipId"]
    characterId = Character["characterId"]

    "#{@endpoint}/Destiny2/#{membershipType}/Account/#{destinyMembershipId}/Character/#{characterId}/Stats/Activities/?count=100"
      |> JSONFetch.fetch
      |> IO.inspect
  end
end
