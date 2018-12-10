# lib/dest_data/constants.ex

defmodule DestData.Constants do

  defmacro __using__(_) do
    quote do
      @api_key Application.get_env(:dest_data, :api_key)
      @endpoint Application.get_env(:dest_data, :dest_endpoint)
      @user_agent Application.get_env(:dest_data, :user_agent)
    end
  end
end

