defprotocol DestData.ApiClient.Message do
  def build_request(message)
  def parse_response(message, response)
end

defmodule DestData.ApiClient do
  def send_request(message) do
    request = DestData.ApiClient.Message.build_request(message)
    response = Http.perform(request)

    DestData.ApiClient.Message.parse_response(message, response)
  end
end

defmodule AccountMessage do
end 
