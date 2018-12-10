defmodule DestData.Accounts do

  use DestData.Constants

  alias __MODULE__
  alias DestData.JSONFetch
  
  @doc """
  Retrieve account scope data from Bungie and Destiny specific endpoints.
  """

  defp get_member(memberId) do
    defmodule Member do
      defstruct [:name]
    end
    "#{@endpoint}/User/GetMembershipsById/#{memberId}/-1/"
  end

  defp get_user(username) do
    defmodule User do
      defstruct [:displayName, :iconPath, :membershipId, :membershipType]
    end

    "#{@endpoint}/Destiny2/SearchDestinyPlayer/2/#{username}/"
      |> fetch
      |> elem(1)
    #|> hd()
  end

  defp get_characters(user) do
    membershipType = user["membershipType"]
    memberId = user["membershipId"]
    "#{@endpoint}/Destiny2/#{membershipType}/Profile/#{memberId}/?components=characters"
      |> fetch
      |> elem(1)
  end

end
