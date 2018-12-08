# lib/dest_data/activities.ex

defmodule DestData.Activities do
  def get_activities(user, character) do
    IO.puts "#{user} and #{character} stuff"
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
end
