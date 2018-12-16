defmodule DestData.Types do
  @doc """
  Collection of types used in this application.
  """
  defmodule User do
    defstruct [:displayName, :iconPath, :membershipId, :membershipType]
    def get(map, key, default), do: Map.get(map, key, default)
    def fetch(term, key), do: Map.fetch(term, key)
  end

  defmodule Character do
    defstruct [:characterId, :classHash, :classType, :dateLastPlayed, :baseCharacterLevel, 
      :genderHash, :genderType, :levelProgression, :light, :minutesPlayedThisSession,
      :minutesPlayedTotal, :percentToNextLevel, :raceHash, :raceType, :stats]
    def get(map, key, default), do: Map.get(map, key, default)
    def fetch(term, key), do: Map.fetch(term, key)
  end 

  defmodule Activity do
    defstruct [:activityDetails, :period, :values]
    def get(map, key, default), do: Map.get(map, key, default)
    def fetch(term, key), do: Map.fetch(term, key)
  end

  defmodule Datatable do
    defstruct data: [[]], index: [], header: []
  end

end
