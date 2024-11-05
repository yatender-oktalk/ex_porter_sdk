defmodule ExPorterSDK.Client.Config do
  @moduledoc "Configuration for the ExPorterSDK client"

  @type t :: %__MODULE__{
          base_url: String.t(),
          api_key: String.t()
        }

  defstruct [:base_url, :api_key]

  @spec base_url() :: String.t()
  def base_url do
    System.get_env("PORTER_BASE_URL", "https://pfe-apigw-uat.porter.in")
  end

  @spec api_key() :: String.t()
  def api_key do
    System.fetch_env!("PORTER_API_KEY")
  end

  @spec new() :: %__MODULE__{}
  def new do
    struct!(__MODULE__, base_url: base_url(), api_key: api_key())
  end
end
