defmodule ExPorterSDK.Config do
  @moduledoc """
  Configuration for Porter SDK.
  """

  def base_url, do: Application.get_env(:ex_porter_sdk, :base_url)
  def api_key, do: Application.get_env(:ex_porter_sdk, :api_key)

  def get do
    %{
      base_url: base_url(),
      api_key: api_key()
    }
  end
end
