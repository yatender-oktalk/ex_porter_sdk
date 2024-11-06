defmodule ExPorterSDK.Client.Config do
  @moduledoc """
  Configuration for the ExPorterSDK client.

  This module provides functions to retrieve and manage the configuration
  settings for the ExPorterSDK client, including the base URL and API key.
  """

  @type t :: %__MODULE__{
          base_url: String.t(),
          api_key: String.t()
        }

  defstruct [:base_url, :api_key]

  @doc """
  Retrieves the base URL for the ExPorterSDK client.

  The base URL is fetched from the `PORTER_BASE_URL` environment variable.
  If the environment variable is not set, it defaults to "https://pfe-apigw-uat.porter.in".

  ## Examples

      iex> ExPorterSDK.Client.Config.base_url()
      "https://pfe-apigw-uat.porter.in"

  """
  @spec base_url() :: String.t()
  def base_url do
    System.get_env("PORTER_BASE_URL", "https://pfe-apigw-uat.porter.in")
  end

  @doc """
  Retrieves the API key for the ExPorterSDK client.

  The API key is fetched from the `PORTER_API_KEY` environment variable.
  If the environment variable is not set, an error is raised.

  ## Examples

      iex> ExPorterSDK.Client.Config.api_key()
      "your_api_key"

  """
  @spec api_key() :: String.t()
  def api_key do
    System.fetch_env!("PORTER_API_KEY")
  end

  @doc """
  Creates a new configuration struct for the ExPorterSDK client.

  The configuration struct contains the base URL and API key.

  ## Examples

      iex> ExPorterSDK.Client.Config.new()
      %ExPorterSDK.Client.Config{
        base_url: "https://pfe-apigw-uat.porter.in",
        api_key: "your_api_key"
      }

  """
  @spec new() :: %__MODULE__{}
  def new do
    struct!(__MODULE__, base_url: base_url(), api_key: api_key())
  end
end
