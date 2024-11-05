defmodule ExPorterSDK.Client do
  alias ExPorterSDK.Client.Config

  @spec base_url(%Config{}) :: String.t()
  def base_url(%Config{base_url: base_url}), do: base_url

  @spec api_key(%Config{}) :: String.t()
  def api_key(%Config{api_key: api_key}), do: api_key
end
