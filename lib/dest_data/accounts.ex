defmodule DestData.Accounts do
  import DestData
  alias DestData.JSONFetch
  @endpoint Application.get_env(:dest_data, :dest_endpoint)
 

  @doc """
  Retrieve account scope data from Bungie and Destiny specific endpoints.
  """

  def get_member(memberId) do
    defmodule Member do
      defstruct [:name]
    end
    "#{@endpoint}/User/GetMembershipsById/#{memberId}/-1/"
  end

  def get_user(username) do
    IO.puts(username)
    defmodule User do
      defstruct [:displayName, :iconPath, :membershipId, :membershipType]
    end

    "#{@endpoint}/Destiny2/SearchDestinyPlayer/2/#{username}/"
      |> JSONFetch.fetch
      |> elem(1)
      |> hd()
  end
end
